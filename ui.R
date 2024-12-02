ui <- fluidPage(
  useShinyjs(),
  use_waiter(),
  
  # Enhanced CSS
  tags$head(
    tags$link(href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap", rel="stylesheet"),
    tags$link(rel="stylesheet", href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"),
    tags$style(HTML("



    /* Info Panel Styling */
    .info-panel {
      background: linear-gradient(rgba(0, 0, 0, 0.05), rgba(0, 0, 0, 0.35)), 
                  url('https://raw.githubusercontent.com/hargunYashkumar/InsightFlow/main/x10.jpg');
      background-size: cover;
      background-position: center;
      padding: 50px 0;
      display: none;
    }

    .info-card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 20px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.1);
      backdrop-filter: blur(10px);
    }

    .info-card h3 {
      color: #2193b0;
      margin-bottom: 20px;
      text-align: center;
    }
    .row {
    display: -webkit-flex;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}
    .info-card h4 {
      color: #2c3e50;
      margin-top: 15px;
    }

    .info-content ul {
      padding-left: 20px;
    }

    .info-content li {
      margin-bottom: 10px;
    }
    /* Video Background Styling */
      .video-background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        overflow: hidden;
        opacity: 0.3;
      }

      .video-background video {
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
      }

      /* Transparent Horizontal Navbar */
      .top-navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      }

      .top-navbar-links {
        display: flex;
        gap: 20px;
      }

      .top-navbar a {
        color: white;
        text-decoration: none;
        transition: color 0.3s ease;
      }

      .top-navbar a:hover {
        color: #6dd5ed;
      }
      .team-section{
        height:100vh;
      }
      /* Sidebar Navigation Dots */
      .sidebar-nav-dots {
        position: fixed;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        flex-direction: column;
        gap: 15px;
        z-index: 1100;
      }

      .nav-dot {
        width: 12px;
        height: 12px;
        background: rgba(255,255,255,0.5);
        border-radius: 50%;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .nav-dot:hover, .nav-dot.active {
        background: #2193b0;
        transform: scale(1.2);
      }
     /* Google Auth Button Styling */
      .google-btn {
        width: 100%;
        margin-top: 15px;
        padding: 10px;
        border-radius: 25px;
        background-color: white;
        border: 1px solid #dadce0;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        font-family: 'Roboto', sans-serif;
      }
      /* General Styling */
      body {
        font-family: 'Poppins', sans-serif;
        background-color: #f5f7fa;
        margin: 0;
        padding: 0;
      }
      
      /* Hero Section */
      .hero-section {
      background: linear-gradient(rgba(0, 0, 0, 0.05), rgba(0, 0, 0, 0.35)),
                  url('https://raw.githubusercontent.com/hargunYashkumar/InsightFlow/main/x12.jpg');
      background-size: cover;
      background-position: center;
      height: 100vh;
      display: flex;
          margin: 0;
          padding: 0;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
      padding: 0 20px;
    }
      
      .hero-content {
        max-width: 800px;
      }
      
      .hero-title {
        font-size: 3.5em;
        margin-bottom: 20px;
        animation: fadeInDown 1s ease-out;
      }
      .google-btn:hover {
        background-color: #f8f9fa;
      }
      
      .google-btn img {
        width: 18px;
        height: 18px;
      }
      
      .hero-subtitle {
        font-size: 1.5em;
        margin-bottom: 30px;
        animation: fadeIn 1s ease-out 0.5s both;
      }
      
      /* Features Section */
      .features-section {
      padding: 80px 20px;
      height:100vh;
      background: linear-gradient(rgba(0, 0, 0, 0.05), rgba(0, 0, 0, 0.35)),
                  url('https://raw.githubusercontent.com/hargunYashkumar/InsightFlow/main/x9.jpg');
      background-size: cover;
      padding-top:17vh;
      background-position: center;
    }
      
      .feature-card {
        background: white;
        border-radius: 10px;
        padding: 30px;
        margin: 15px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
        animation: fadeInUp 1s ease-out;
      }
      
      .feature-card:hover {
        transform: translateY(-10px);
      }
      


      
      
      /* Team Section */
      .team-section {
      background: linear-gradient(rgba(0, 0, 0, 0.05), rgba(0, 0, 0, 0.35)),
                  url('https://raw.githubusercontent.com/hargunYashkumar/InsightFlow/main/x5.jpg');
      padding: 50px 50px;
      background-size: cover;
      height: 100vh;
          padding-top: 10vh;
      background-position: center;
    }
      .tab-1040-6{
        padding:15px;
      }
      .team-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        margin: 15px;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
      }
      
      .team-card:hover {
        transform: translateY(-5px);
      }
      
      .team-avatar {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        margin: 0 auto 20px;
        object-fit: cover;
      }

      /* Features Section */
      .features-section1 {
      padding: 80px 20px;
      height:100vh;
      background: linear-gradient(rgba(0, 0, 0, 0.05), rgba(0, 0, 0, 0.35)),
                  url('https://raw.githubusercontent.com/hargunYashkumar/InsightFlow/main/x7.jpg');
      background-size: cover;
          padding-top: 20vh;
      background-position: center;
    }
      
      .feature-card1 {
        background: white;
        border-radius: 10px;
        padding: 30px;
        margin: 15px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
        animation: fadeInUp 1s ease-out;
      }
      
      .feature-card1:hover {
        transform: translateY(-10px);
      }
      .div#tab-9564-6 {
        padding: 16px;
      }
      
      /* Auth Panel Styling */
      .auth-panel {
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        background: white;
        animation: fadeInUp 1s ease-out;
      }
      
      /* Enhanced Button Styling */
      .btn-primary {
        background: linear-gradient(45deg, #2193b0, #6dd5ed);
        border: none;
        padding: 12px 25px;
        border-radius: 25px;
        transition: all 0.3s ease;
      }
      
      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
      }
      body h2 {
        color: white;
      }

      
      /* Animations */
      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      
      /* Enhanced Auth Panel */
        .auth-panel {
          background: rgba(255, 255, 255, 0.95);
          backdrop-filter: blur(10px);
          border: none;
          border-radius: 20px;
          box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }
      
      /* Smooth Navigation */
        .navbar {
          background: linear-gradient(90deg, #2c3e50, #3498db);
                                      border: none;
                                      padding: 1rem 2rem;
        }
        
        
        
       /* New navbar tab content margin and padding */
      .navbar:not(.fixed-bottom):not(.navbar-fixed-bottom):not(.navbar-fixed-bottom)+div>.tab-content>.tab-pane {
        --bslib-navbar-margin: 20px;
        margin-top: var(--bslib-navbar-margin);
        padding: 15px;
      }
  
      /* Container full width and zero padding */
      .container, .container-fluid, .container-xl, .container-lg, .container-md, .container-sm {
        width: 100%;
        padding-right: 0px;
        padding-left: 0px;
        margin-right: auto;
        margin-left: auto;
      }
      
            
      

      /* Seamless Feature Cards */
        .feature-card {
          background: linear-gradient(145deg, #ffffff, #f3f3f3);
                                      border: none;
                                      border-radius: 15px;
                                      padding: 2rem;
                                      margin: 1rem 0;
                                      transition: all 0.3s ease;
                                      box-shadow: 7px 2px 5px rgba(0,0,0,0.05), -3px -1px 19px rgb(255 255 255 / 91%);
        }

      .feature-card:hover {
        transform: translateY(-5px);
        box-shadow: 8px 8px 20px rgba(0,0,0,0.1),
        -8px -8px 20px rgba(255,255,255,0.9);
      }

      /* Enhanced Auth Panel */
        .auth-panel {
          background: rgba(255, 255, 255, 0.95);
          backdrop-filter: blur(10px);
          border: none;
          border-radius: 20px;
          box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }

      /* Smooth Navigation */
        .navbar {
          background: linear-gradient(90deg, #2c3e50, #3498db);
                                      border: none;
                                      padding: 1rem 2rem;
        }

      .navbar-nav .nav-link {
        color: white !important;
        transition: all 0.3s ease;
        padding: 0.5rem 1rem;
        margin: 0 0.25rem;
        border-radius: 5px;
      }

      .navbar-nav .nav-link:hover {
        background: rgba(255,255,255,0.1);
      }

      /* Enhanced Data Tables */
        .dataTables_wrapper {
          background: transparent;
          padding: 1.5rem !important;
          border-radius: 15px;
          box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

      .table {
        background: transparent;
        border-collapse: separate;
        border-spacing: 0 0.5rem;
      }

      .table thead th {
        background: #f8f9fa;
          border: none;
        padding: 1rem;
      }

      .table tbody td {
        background: white;
        border: none;
        padding: 1rem;
      }

      /* Enhanced Plot Containers */
        .plotly, .plot-container {
          background: transparent !important;
          border-radius: 15px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.05);
          padding: 1rem;
        }

      /* Custom Scrollbar */
        ::-webkit-scrollbar {
          width: 8px;
          height: 8px;
        }

      ::-webkit-scrollbar-track {
        background: #f1f1f1;
      }

      ::-webkit-scrollbar-thumb {
        background: #888;
          border-radius: 4px;
      }

      ::-webkit-scrollbar-thumb:hover {
        background: #555;
      }

      /* Enhanced Input Fields */
        .form-control {
          border: none;
          border-radius: 8px;
          padding: 0.75rem 1rem;
          background: #f8f9fa;
            box-shadow: inset 2px 2px 5px rgba(0,0,0,0.05);
          transition: all 0.3s ease;
        }

      .form-control:focus {
        box-shadow: inset 2px 2px 5px rgba(0,0,0,0.1);
        background: white;
      }

      /* Loading Animation Enhancement */
        .waiter-overlay {
          backdrop-filter: blur(5px);
          background: rgba(255,255,255,0.8) !important;
        }

      /* Team Section Enhancement */
        .team-card {
          background: linear-gradient(145deg, #ffffff, #f3f3f3);
                                      border: none;
                                      padding: 2rem;
                                      border-radius: 20px;
                                      box-shadow: 5px 5px 15px rgba(0,0,0,0.05),
                                      -5px -5px 15px rgba(255,255,255,0.8);
        }

      .team-avatar {
        border: 5px solid white;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      }
      .info-panel{
        height:100vh;
      }

      /* Enhanced Buttons */
        .btn {
          border: none;
          padding: 0.75rem 1.5rem;
          border-radius: 10px;
          transition: all 0.3s ease;
          text-transform: uppercase;
          letter-spacing: 1px;
          font-weight: 600;
          border-radius: 25px
        }

      .btn-primary {
        background: linear-gradient(45deg, #2193b0, #6dd5ed);
                                    box-shadow: 0 4px 15px rgba(33,147,176,0.3);
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(33,147,176,0.4);
      }


      /* Notification Enhancement */
        .shiny-notification {
          border-radius: 10px;
          border: none;
          box-shadow: 0 4px 15px rgba(0,0,0,0.1);
          background: white;
          padding: 1rem;
        }

        
      
    "))
  ),
  
  # Replace the existing tags$script for navigation dots with this

tags$script(HTML("
document.addEventListener('DOMContentLoaded', function() {
  // Get all navigation dots
  var navDots = document.querySelectorAll('.nav-dot');
  
  // Add click event listener to each dot
  navDots.forEach(function(dot) {
    dot.addEventListener('click', function() {
      // Get the target section ID from data-section attribute
      var sectionId = this.getAttribute('data-section');
      
      // Find the target section
      var section = document.getElementById(sectionId);
      
      // If section exists, scroll to it smoothly
      if (section) {
        section.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
        
        // Remove active class from all dots
        navDots.forEach(function(d) {
          d.classList.remove('active');
        });
        
        // Add active class to clicked dot
        this.classList.add('active');
      }
    });
  });
});
")),

  tags$script(HTML("
    $(document).ready(function() {
      // Initially hide the auth panel
      $('.auth-panel').hide();
      
      // Scroll and show auth panel when button is clicked
      $('#scroll_to_auth').click(function() {
        $('.auth-panel').show();
        $('html, body').animate({
          scrollTop: $('.auth-panel').offset().top
        }, 1000);
      });
    });
  ")),
  
  # Homepage/Auth UI
  div(
    id = "auth_page",
    class = "fade-in",
    
    
  # Video Background
  div(
    class = "video-background",
    tags$video(
      autoplay = NA, 
      loop = NA, 
      muted = NA,
      tags$source(
        src = "https://www.example.com/background-video.mp4", 
        type = "video/mp4"
      )
    )
  ),
  
    # Add this to your top navbar
div(
  class = "top-navbar",
  div(
    class = "top-navbar-links",
    tags$a(href = "#", id = "login-nav-btn", "Login"),
    tags$a(href = "#", id = "info-panel-btn", "About")
  )
),

# Add a new section for the information panel
div(
  id = "info-panel",
  class = "info-panel",
  div(
    class = "container",
    div(
      class = "row",
      div(
        class = "col-md-6",
        div(
          class = "info-card",
          h3("Copyrights & Licenses"),
          tags$hr(),
          div(
            class = "info-content",
            HTML("
              <h4>Copyrights</h4>
              <p>© 2024 InsightFlow Dashboard. All Rights Reserved.</p>
              
              <h4>Software Licenses</h4>
              <ul>
                <li><strong>Dashboard Software:</strong> MIT License</li>
                <li><strong>Data Visualization:</strong> Apache 2.0 License</li>
                <li><strong>Machine Learning Components:</strong> Open-Source</li>
              </ul>
              
              <h4>Usage Terms</h4>
              <p>Free for non-commercial use. Commercial licensing available upon request.</p>
            ")
          )
        )
      ),
      div(
        class = "col-md-6",
        div(
          class = "info-card",
          h3("Tools & Technologies"),
          tags$hr(),
          div(
            class = "info-content",
            HTML("
              <h4>Core Technologies</h4>
              <ul>
                <li><strong>Frontend:</strong> R Shiny, HTML5, CSS3</li>
                <li><strong>Backend:</strong> R, Python</li>
                <li><strong>Data Processing:</strong> 
                  <ul>
                    <li>Pandas</li>
                    <li>Tidyverse</li>
                  </ul>
                </li>
                <li><strong>Machine Learning:</strong> 
                  <ul>
                    <li>Scikit-learn</li>
                    <li>TensorFlow</li>
                  </ul>
                </li>
                <li><strong>Visualization:</strong> 
                  <ul>
                    <li>Plotly</li>
                    <li>ggplot2</li>
                  </ul>
                </li>
              </ul>
              
              <h4>Infrastructure</h4>
              <p>Cloud-enabled, scalable architecture supporting advanced analytics.</p>
            ")
          )
        )
      )
    )
  )
),

# Add JavaScript to toggle info panel
tags$script(HTML("
document.addEventListener('DOMContentLoaded', function() {
  var infoPanel = document.getElementById('info-panel');
  var infoPanelBtn = document.getElementById('info-panel-btn');
  var loginNavBtn = document.getElementById('login-nav-btn');
  
  // Initially hide the info panel
  infoPanel.style.display = 'none';
  
  // Toggle info panel
  infoPanelBtn.addEventListener('click', function() {
    if (infoPanel.style.display === 'none') {
      infoPanel.style.display = 'block';
      loginNavBtn.closest('.auth-panel').style.display = 'none';
    } else {
      infoPanel.style.display = 'none';
    }
  });
  
  // Login button functionality
  loginNavBtn.addEventListener('click', function() {
    infoPanel.style.display = 'none';
    var authPanel = document.querySelector('.auth-panel');
    if (authPanel) {
      authPanel.style.display = 'block';
      authPanel.scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      });
    }
  });
});
")),
    
    # Sidebar Navigation Dots
    div(
      class = "sidebar-nav-dots",
      div(class = "nav-dot", `data-section` = "hero"),
      div(class = "nav-dot", `data-section` = "features"),
      div(class = "nav-dot", `data-section` = "team"),
      div(class = "nav-dot", `data-section` = "how-it-works")
    ),

    # Hero Section
    div(
      id = "hero",
      class = "hero-section",
      div(
        class = "hero-content",
        h1("Welcome to InsightFlow Dashboard", class = "hero-title"),
        p("Transforming Data into Actionable Insights", class = "hero-subtitle"),
        actionButton("scroll_to_auth", "Get Started", 
                     class = "btn btn-primary btn-lg animate__animated animate__pulse animate__infinite")
      )
    ),
    
    # Features Section
    div(
      id = "features", 
      class = "features-section",
      h2("What We Provide", class = "text-center mb-5"),
      div(
        class = "row",
        div(
          class = "col-md-4",
          div(
            id='z9',
            class = "feature-card",
            tags$i(class = "fas fa-chart-line fa-3x mb-4"),
            h4("Advanced Analytics"),
            p("Comprehensive data analysis tools with interactive visualizations and real-time processing capabilities.")
          )
        ),
        div(
          class = "col-md-4",
          div(
            id='z10',
            class = "feature-card",
            tags$i(class = "fas fa-brain fa-3x mb-4"),
            h4("Machine Learning"),
            p("Predictive analytics powered by sophisticated machine learning algorithms.")
          )
        ),
        div(
          class = "col-md-4",
          div(
            id='z3',
            class = "feature-card",
            tags$i(class = "fas fa-project-diagram fa-3x mb-4"),
            h4("3D Visualization"),
            p("Advanced 3D plotting capabilities for complex data representation.")
          )
        )
      )
    ),
    
    # Team Section
    div(
      id = "team",
      class = "team-section",
      h2("Meet Our Team", class = "text-center mb-5"),
      div(
        class = "row",
        div(
          class = "col-md-6",
          div(
            id="z1",
            class = "team-card",
            img(src = "https://via.placeholder.com/150", class = "team-avatar"),
            h4("Gunjan Bhojwani"),
            p("Lead Developer"),
            p("Specializes in machine learning and data visualization. Passionate about creating intuitive user experiences.")
          )
        ),
        div(
          class = "col-md-6",
          div(
            id="z2",
            class = "team-card",
            img(src = "https://via.placeholder.com/150", class = "team-avatar"),
            h4("Hargun YashKumar"),
            p("Senior Developer"),
            p("Expert in statistical analysis and backend development. Focuses on system architecture and performance optimization.")
          )
        )
      )
    ),
    
    # How It Works Section
    div(
      id = "how-it-works",
      class = "features-section1",
      h2("How It Works", class = "text-center mb-5"),
      div(
        class = "row",
        div(
          id='z3',
          class = "col-md-3",
          div(
            
            class = "feature-card1",
            h4("1. Upload Data"),
            p("Simply upload your CSV file containing sales data.")
          )
        ),
        div(
            id='z4',
          class = "col-md-3",
          div(
            class = "feature-card1",
            h4("2. Choose Analysis"),
            p("Select from various visualization and analysis options.")
          )
        ),
        div(
            id='z5',
          class = "col-md-3",
          div(
            class = "feature-card1",
            h4("3. Generate Insights"),
            p("Get automatic insights and predictions from your data.")
          )
        ),
        div(
            id='z6',
          class = "col-md-3",
          div(
            class = "feature-card1",
            h4("4. Export Results"),
            p("Download reports and visualizations for your use.")
          )
        )
      )
    ),
    
    # Auth Panel
    div(
      class = "auth-panel",
      tabsetPanel(
        id = "auth_tabs",
        tabPanel(
          "Login",
          div(
            style = "padding: 20px 0;",
            textInput("login_username", "Username", 
                      placeholder = "Enter your username"),
            passwordInput("login_password", "Password",
                          placeholder = "Enter your password"),
            actionButton("login_btn", "Login", 
                         class = "btn-primary", 
                         style = "width: 100%; margin-top: 15px;"),
            div(
              style = "text-align: center; margin-top: 15px;",
              "OR"
            ),
            actionButton(
              inputId = "google_login_btn",
              class = "google-btn",
              icon = icon("google"),
              label = "Login with Google"
            )
          )
        ),
        tabPanel(
          "Register",
          div(
            style = "padding: 20px 0;",
            textInput("register_username", "Username",
                      placeholder = "Choose a username"),
            textInput("register_email", "Email",
                      placeholder = "Enter your email"),
            passwordInput("register_password", "Password",
                          placeholder = "Choose a password"),
            passwordInput("register_password_confirm", "Confirm Password",
                          placeholder = "Confirm your password"),
            actionButton("register_btn", "Register", 
                         class = "btn-primary",
                         style = "width: 100%; margin-top: 15px;")
          )
        )
      )
    )
  ),
  
  # Main Dashboard UI (remains the same)
  shinyjs::hidden(
    div(
      id = "main_app",
      class = "fade-in",

      
      # Enhanced Dashboard UI
      navbarPage(
        "Sales Analytics Dashboard",
        theme = bs_theme(
          version = 4,
          bootswatch = "flatly",
          primary = "#2c3e50",
          secondary = "#95a5a6"
        ),
        # Main Dashboard
        tabPanel("Dashboard",
                 fluidRow(
                   column(12,
                          wellPanel(
                            fileInput("file", "Upload CSV File"),
                            DTOutput("data_table"),
                            hr(),
                            h3("Summary"),
                            textOutput("summary_text")
                          )
                   )
                 )
        ),
        # Basic Graphs
        tabPanel("Basic Graphs",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("basic_graph_type", "Select Graph Type",
                                 choices = c("Bar Graph", "Box Plot", "Scatter Plot", "Line Graph"),
                                 selected = "Bar Graph"
                     ),
                     selectInput("basic_x_var", "Select X Variable", choices = ""),
                     selectInput("basic_y_var", "Select Y Variable", choices = ""),
                     conditionalPanel(
                       condition = "input.basic_graph_type == 'Bar Graph' || input.basic_graph_type == 'Line Graph'",
                       selectInput("basic_agg_method", "Aggregation Method",
                                   choices = c("Sum", "Mean", "Count"),
                                   selected = "Sum"
                       )
                     )
                   ),
                   mainPanel(
                     plotlyOutput("basic_plot", height = "600px")
                   )
                 )
        ),
        
        # Advanced Visualization
        tabPanel("Advanced Visualization",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("adv_graph_type", "Select Graph Type",
                                 choices = c("Heatmap", "Treemap"),
                                 selected = "Heatmap"
                     ),
                     selectInput("adv_x_var", "Select X Variable", choices = ""),
                     selectInput("adv_y_var", "Select Y Variable", choices = ""),
                     selectInput("adv_value_var", "Select Value Variable", choices = "")
                   ),
                   mainPanel(
                     plotlyOutput("advanced_plot", height = "600px")
                   )
                 )
        ),
        
        # Machine Learning
        tabPanel("Machine Learning",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("ml_target", "Select Target Variable", choices = ""),
                     selectInput("ml_predictors", "Select Predictor Variables", choices = "", multiple = TRUE),
                     actionButton("run_ml", "Run Analysis", class = "btn-primary")
                   ),
                   mainPanel(
                     verbatimTextOutput("ml_summary"),
                     plotOutput("ml_plot", height = "400px")
                   )
                 )
        ),
        
        # 3D Visualization
        tabPanel("3D Visualization",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("three_d_graph_type", "Select 3D Graph Type",
                                 choices = c("3D Scatter", "3D Surface"),
                                 selected = "3D Scatter"
                     ),
                     selectInput("three_d_x_var", "Select X Variable", choices = ""),
                     selectInput("three_d_y_var", "Select Y Variable", choices = ""),
                     selectInput("three_d_z_var", "Select Z Variable", choices = ""),
                     conditionalPanel(
                       condition = "input.three_d_graph_type == '3D Scatter'",
                       selectInput("three_d_color_var", "Select Color Variable", choices = "")
                     )
                   ),
                   mainPanel(
                     plotlyOutput("three_d_plot", height = "600px")
                   )
                 )
        ),
        tabPanel(
          "Logout",
          div(
            class = "navbar-btn",
            actionButton("logout_btn", "Logout",
                        class = "btn-danger",
                        icon = icon("sign-out-alt"))
          )
        )
      )
      
    )
  )
)



# Server logic for Google Authentication