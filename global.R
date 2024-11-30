# global.R
library(shiny)
library(DT)
library(ggplot2)
library(plotly)
library(heatmaply)
library(treemap)
library(caret)
library(dplyr)
library(tidyr)
library(RSQLite)
library(digest)
library(shinyjs)
library(bslib)
library(googleAuthR) # Add Google Auth library
library(waiter) # For loading animations
library(shinyWidgets) # For enhanced UI elements
library(shiny)
library(DBI)
library(dplyr)
library(RSQLite)

# Google OAuth Credentials
google_client_id <- "663108994897-vtd667mntdbudcjh74hog59famrnesam.apps.googleusercontent.com"
google_client_secret <- ""

# Define OAuth Scopes
scopes <- c(
  "https://www.googleapis.com/auth/userinfo.profile",
  "https://www.googleapis.com/auth/userinfo.email"
)

# Database initialization for user tracking
con <- dbConnect(SQLite(), "user_tracking.db")
dbExecute(con, "
  CREATE TABLE IF NOT EXISTS user_activity (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    logout_time TIMESTAMP
  )
")

# Initialize database with Google auth support
init_db <- function() {
  con <- dbConnect(SQLite(), "user_auth.db")
  
  dbExecute(con, "
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE NOT NULL,
      password TEXT,
      email TEXT UNIQUE NOT NULL,
      google_id TEXT UNIQUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  ")

  
  
  dbDisconnect(con)
}

init_db()


# UI