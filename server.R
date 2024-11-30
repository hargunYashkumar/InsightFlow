

server <- function(input, output, session) {
  
  auth <- reactiveValues(
    logged_in = FALSE,
    user_id = NULL,
    username = NULL,
    token = NULL
  )
  
  # Reactive value to store user information
  user_data <- reactiveVal(NULL)
  
  # Validation Functions
  validate_email <- function(email) {
    email_regex <- "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    return(grepl(email_regex, email))
  }
  
  validate_password <- function(password) {
    return(nchar(password) >= 7)
  }
  
  validate_username <- function(username) {
    # First character must be a letter, minimum 6 characters
    username_regex <- "^[a-zA-Z][a-zA-Z0-9]{5,}$"
    return(grepl(username_regex, username))
  }

  # Google Authentication Handler
  observeEvent(input$google_login_btn, {
    # Configure OAuth Endpoint
    google_oauth <- oauth_endpoint(
      authorize = "https://accounts.google.com/o/oauth2/auth",
      access = "https://accounts.google.com/o/oauth2/token"
    )
    
    # Create OAuth App
    myapp <- oauth_app(
      appname = "google", 
      key = google_client_id, 
      secret = google_client_secret
    )
    
    # Get OAuth Token
    goog_auth <- oauth2.0_token(
      endpoint = google_oauth, 
      app = myapp, 
      scope = scopes, 
      cache = FALSE
    )
    
    # Fetch User Information
    user_info <- GET(
      "https://www.googleapis.com/oauth2/v2/userinfo", 
      config(token = goog_auth)
    )
    
    # Parse User Info
    user_info_data <- content(user_info, "parsed")
    
    # Store User Data
    user_data(user_info_data)
    auth$logged_in<- TRUE;
    # Switch Panels
    shinyjs::hide("auth_page")
    shinyjs::show("main_app")
  })
  
  
  # Login Handler
  observeEvent(input$login_btn, {
    req(input$login_username, input$login_password)
    
    # Connect to database
    con <- dbConnect(SQLite(), "user_auth.db")
    
    # Check credentials
    user <- dbGetQuery(con, "
      SELECT id, username, password 
      FROM users 
      WHERE username = ?
    ", params = list(input$login_username))
    
    dbDisconnect(con)
    
    if (nrow(user) == 1 && user$password == digest(input$login_password, algo = "sha256")) {
      auth$logged_in <- TRUE
      auth$user_id <- user$id
      auth$username <- user$username
      
      # Hide login page and show main app
      shinyjs::hide("auth_page")
      shinyjs::show("main_app")
      
      # Clear login form
      updateTextInput(session, "login_username", value = "")
      updateTextInput(session, "login_password", value = "")
    } else {
      shinyjs::html("login_error", "Invalid username or password")
    }
  })
  
  # Register Handler
  observeEvent(input$register_btn, {
    req(input$register_username, input$register_email,
        input$register_password, input$register_password_confirm)
    
    # Validate inputs
    if (input$register_password != input$register_password_confirm) {
      shinyjs::html("register_error", "Passwords do not match")
      return()
    }
    
    # Additional Validations
    if (!validate_username(input$register_username)) {
      shinyjs::html("register_error", "Username must start with a letter and be at least 6 characters long")
      return()
    }
    
    if (!validate_email(input$register_email)) {
      shinyjs::html("register_error", "Please enter a valid email address")
      return()
    }
    
    if (!validate_password(input$register_password)) {
      shinyjs::html("register_error", "Password must be at least 7 characters long")
      return()
    }
    
    # Connect to database
    con <- dbConnect(SQLite(), "user_auth.db")
    
    # Check if username or email already exists
    existing <- dbGetQuery(con, "
      SELECT username, email 
      FROM users 
      WHERE username = ? OR email = ?
    ", params = list(input$register_username, input$register_email))
    
    if (nrow(existing) > 0) {
      shinyjs::html("register_error", "Username or email already exists")
      dbDisconnect(con)
      return()
    }
    
    # Insert new user
    tryCatch({
      dbExecute(con, "
        INSERT INTO users (username, email, password)
        VALUES (?, ?, ?)
      ", params = list(
        input$register_username,
        input$register_email,
        digest(input$register_password, algo = "sha256")
      ))
      
      # Clear registration form
      updateTextInput(session, "register_username", value = "")
      updateTextInput(session, "register_email", value = "")
      updateTextInput(session, "register_password", value = "")
      updateTextInput(session, "register_password_confirm", value = "")
      
      # Switch to login tab
      updateTabsetPanel(session, "auth_tabs", selected = "Login")
      
    }, error = function(e) {
      shinyjs::html("register_error", "Registration failed. Please try again.")
    })
    
    dbDisconnect(con)
  })
  
  # Logout Handler
  observeEvent(input$logout_btn, {
    auth$logged_in <- FALSE
    auth$user_id <- NULL
    auth$username <- NULL
    
    # Hide main app and show login page
    shinyjs::hide("main_app")
    shinyjs::show("auth_page")
  })
  
  # Original server logic - wrap in observe block to ensure user is logged in
  observe({
    req(auth$logged_in)
    
    # Data handling
    data <- reactive({
      req(input$file)
      df <- read.csv(input$file$datapath)
      df[] <- lapply(df, function(x) if(is.character(x)) as.factor(x) else x)
      return(df)
    })
    
    # Update dropdown choices when data is loaded
    observe({
      req(data())
      choices <- names(data())
      numeric_choices <- names(which(sapply(data(), is.numeric)))
      
      updateSelectInput(session, "basic_x_var", choices = c("", choices))
      updateSelectInput(session, "basic_y_var", choices = c("", numeric_choices))
      updateSelectInput(session, "adv_x_var", choices = c("", choices))
      updateSelectInput(session, "adv_y_var", choices = c("", choices))
      updateSelectInput(session, "adv_value_var", choices = c("", numeric_choices))
      updateSelectInput(session, "ml_target", choices = c("", numeric_choices))
      updateSelectInput(session, "three_d_x_var", choices = c("", numeric_choices))
      updateSelectInput(session, "three_d_y_var", choices = c("", numeric_choices))
      updateSelectInput(session, "three_d_z_var", choices = c("", numeric_choices))
      updateSelectInput(session, "three_d_color_var", choices = c("", choices))
    })
    
    # Original outputs
    output$data_table <- renderDT({
      req(data())
      datatable(data(), options = list(pageLength = 5, scrollX = TRUE))
    })
    
    output$summary_text <- renderText({
      req(data())
      paste("Total rows:", nrow(data()), 
            "| Total columns:", ncol(data()),
            "| Numeric columns:", sum(sapply(data(), is.numeric)))
    })
    
    # [Rest of your original server code remains the same]


    # Basic Plots
    output$basic_plot <- renderPlotly({
      if (input$basic_x_var == "" || input$basic_y_var == "") {
        return(plot_ly() %>% 
                 add_annotations(text = "Please select fields to continue",
                                 showarrow = FALSE,
                                 font = list(size = 20)))
      }
      
      req(data(), input$basic_x_var, input$basic_y_var)
      
      df <- data()
      
      if(input$basic_graph_type %in% c("Bar Graph", "Line Graph")) {
        df <- switch(input$basic_agg_method,
                     "Sum" = df %>% group_by_at(input$basic_x_var) %>% 
                       summarise(y = sum(get(input$basic_y_var)), .groups = 'drop'),
                     "Mean" = df %>% group_by_at(input$basic_x_var) %>% 
                       summarise(y = mean(get(input$basic_y_var)), .groups = 'drop'),
                     "Count" = df %>% group_by_at(input$basic_x_var) %>% 
                       summarise(y = n(), .groups = 'drop')
        )
        colnames(df)[2] <- input$basic_y_var
      }
      
      p <- switch(input$basic_graph_type,
                  "Bar Graph" = ggplot(df, aes_string(x = input$basic_x_var, y = input$basic_y_var)) +
                    geom_bar(stat = "identity", fill = "steelblue") +
                    theme_minimal() +
                    theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                  
                  "Box Plot" = ggplot(df, aes_string(x = input$basic_x_var, y = input$basic_y_var)) +
                    geom_boxplot(fill = "steelblue") +
                    theme_minimal() +
                    theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                  
                  "Scatter Plot" = ggplot(df, aes_string(x = input$basic_x_var, y = input$basic_y_var)) +
                    geom_point(color = "steelblue") +
                    theme_minimal(),
                  
                  "Line Graph" = ggplot(df, aes_string(x = input$basic_x_var, y = input$basic_y_var, group = 1)) +
                    geom_line(color = "steelblue") +
                    theme_minimal() +
                    theme(axis.text.x = element_text(angle = 45, hjust = 1))
      )
      
      ggplotly(p)
    })
    
    # Advanced Plots
    output$advanced_plot <- renderPlotly({
      if (input$adv_x_var == "" || input$adv_y_var == "" || input$adv_value_var == "") {
        return(plot_ly() %>% 
                 add_annotations(text = "Please select fields to continue",
                                 showarrow = FALSE,
                                 font = list(size = 20)))
      }
      
      req(data(), input$adv_x_var, input$adv_y_var, input$adv_value_var)
      
      if (input$adv_graph_type == "Heatmap") {
        df_summary <- data() %>%
          group_by_at(vars(input$adv_x_var, input$adv_y_var)) %>%
          summarise(value = sum(get(input$adv_value_var)), .groups = 'drop') %>%
          spread(key = !!sym(input$adv_y_var), value = value)
        
        matrix_data <- as.matrix(df_summary[,-1])
        rownames(matrix_data) <- df_summary[[input$adv_x_var]]
        
        heatmaply(matrix_data,
                  main = "Heatmap Analysis",
                  xlab = input$adv_y_var,
                  ylab = input$adv_x_var)
      } else {
        df_summary <- data() %>%
          group_by_at(vars(input$adv_x_var, input$adv_y_var)) %>%
          summarise(value = sum(get(input$adv_value_var)), .groups = 'drop')
        
        plot_ly(
          type = "treemap",
          labels = paste(df_summary[[input$adv_x_var]], df_summary[[input$adv_y_var]]),
          parents = rep("", nrow(df_summary)),
          values = df_summary$value
        )
      }
    })
    
    # ML-related server logic
    observeEvent(input$ml_target, {
      req(data(), input$ml_target)
      numeric_cols <- names(which(sapply(data(), is.numeric)))
      predictor_choices <- setdiff(numeric_cols, input$ml_target)
      updateSelectInput(session, "ml_predictors",
                        choices = predictor_choices,
                        selected = predictor_choices[1:min(3, length(predictor_choices))])
    })
    
    # Improved ML model with validation and diagnostics
    ml_model <- eventReactive(input$run_ml, {
      req(data(), input$ml_target, length(input$ml_predictors) > 0)
      
      # Prepare data
      model_data <- data() %>%
        select(c(input$ml_target, input$ml_predictors)) %>%
        na.omit()
      
      # Split data into training and testing sets
      set.seed(123)
      train_index <- createDataPartition(model_data[[input$ml_target]], p = 0.8, list = FALSE)
      train_data <- model_data[train_index, ]
      test_data <- model_data[-train_index, ]
      
      # Fit model
      formula_str <- paste(input$ml_target, "~", paste(input$ml_predictors, collapse = " + "))
      model <- lm(as.formula(formula_str), data = train_data)
      
      # Make predictions on test set
      predictions <- predict(model, newdata = test_data)
      
      # Calculate performance metrics
      rmse <- sqrt(mean((test_data[[input$ml_target]] - predictions)^2))
      r2 <- cor(test_data[[input$ml_target]], predictions)^2
      mae <- mean(abs(test_data[[input$ml_target]] - predictions))
      
      # Return list with model and metrics
      list(
        model = model,
        metrics = list(
          rmse = rmse,
          r2 = r2,
          mae = mae
        ),
        test_actual = test_data[[input$ml_target]],
        test_predicted = predictions
      )
    })
    
    # Render ML results
    output$ml_summary <- renderPrint({
      req(ml_model())
      
      # Get model results
      model_results <- ml_model()
      model <- model_results$model
      metrics <- model_results$metrics
      
      # Create summary
      cat("=== MODEL SUMMARY ===\n\n")
      print(summary(model))
      
      cat("\n=== MODEL PERFORMANCE ===\n")
      cat(sprintf("R-squared (Test Set): %.3f\n", metrics$r2))
      cat(sprintf("RMSE: %.3f\n", metrics$rmse))
      cat(sprintf("MAE: %.3f\n", metrics$mae))
      
      cat("\n=== VARIABLE IMPORTANCE ===\n")
      importance <- abs(coef(model)[-1])  # Exclude intercept
      var_importance <- data.frame(
        Variable = names(importance),
        Importance = importance
      )
      var_importance <- var_importance[order(-var_importance$Importance), ]
      print(var_importance)
    })
    
    # Add diagnostic plots
    output$ml_plot <- renderPlot({
      req(ml_model())
      
      model_results <- ml_model()
      
      par(mfrow = c(2, 2))
      
      # Actual vs Predicted Plot
      plot(model_results$test_actual, model_results$test_predicted,
           xlab = "Actual Values",
           ylab = "Predicted Values",
           main = "Actual vs Predicted",
           pch = 16, col = "steelblue")
      abline(0, 1, col = "red", lty = 2)
      
      # Residuals vs Fitted
      plot(model_results$model, which = 1)
      
      # Normal Q-Q
      plot(model_results$model, which = 2)
      
      # Scale-Location
      plot(model_results$model, which = 3)
    })
    
    # 3D Plots
    output$three_d_plot <- renderPlotly({
      if (input$three_d_x_var == "" || input$three_d_y_var == "" || input$three_d_z_var == "") {
        return(plot_ly() %>% 
                 add_annotations(text = "Please select fields to continue",
                                 showarrow = FALSE,
                                 font = list(size = 20)))
      }
      
      req(data(), input$three_d_x_var, input$three_d_y_var, input$three_d_z_var)
      
      if (input$three_d_graph_type == "3D Scatter") {
        plot <- plot_ly(data(),
                        x = as.formula(paste0("~", input$three_d_x_var)),
                        y = as.formula(paste0("~", input$three_d_y_var)),
                        z = as.formula(paste0("~", input$three_d_z_var)),
                        type = "scatter3d",
                        mode = "markers"
        )
        
        if (!is.null(input$three_d_color_var) && input$three_d_color_var != "") {
          plot <- plot %>% add_trace(
            color = as.formula(paste0("~", input$three_d_color_var)),
            marker = list(size = 5)
          )
        }
        
        plot %>% layout(scene = list(
          xaxis = list(title = input$three_d_x_var),
          yaxis = list(title = input$three_d_y_var),
          zaxis = list(title = input$three_d_z_var)
        ))
      } else {
        df_summary <- data() %>%
          group_by_at(vars(input$three_d_x_var, input$three_d_y_var)) %>%
          summarise(z = sum(get(input$three_d_z_var)), .groups = 'drop') %>%
          spread(key = !!sym(input$three_d_y_var), value = z)
        
        matrix_data <- as.matrix(df_summary[,-1])
        
        plot_ly(z = ~matrix_data, type = "surface")
      }
    })
  })
}

# Run the application