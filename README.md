# InsightFlow

**InsightFlow** is an interactive data analytics platform that empowers users to analyze their data and extract meaningful insights. Built with [Shiny](https://shiny.rstudio.com/) and a range of advanced R libraries, InsightFlow offers seamless integration with powerful data visualization and machine learning tools.

---

## 🚀 Overview

InsightFlow is designed to:
- Simplify the process of analyzing complex datasets.
- Provide intuitive, interactive visualizations.
- Enable advanced analytics using built-in machine learning capabilities.
- Securely manage user authentication through Google OAuth.

---

## ✨ Features

- **Interactive Visualizations**: Dynamic charts and plots powered by `ggplot2`, `plotly`, and `heatmaply`.
- **Data Analytics**: Tools for clustering, classification, and regression using `caret`.
- **Data Management**: Robust integration with databases through `RSQLite`.
- **User Authentication**: Secure login and session management with Google OAuth.
- **Customizable UI**: Enhanced UI components with `shinyWidgets` and `bslib`.
- **Real-Time Updates**: Reactive capabilities for instant feedback on user actions.

---

## 🛠️ Technologies Used

- **Core Framework**: Shiny
- **Visualization**: ggplot2, plotly, heatmaply, treemap
- **Machine Learning**: caret
- **Database Integration**: RSQLite, DBI
- **Authentication**: googleAuthR
- **UI Components**: shinyWidgets, shinyjs, bslib
- **Loading Animations**: waiter

---

## 🧩 Setup Instructions

### Prerequisites
- **R**: Ensure you have R installed ([Download R](https://www.r-project.org/)).
- **RStudio**: Recommended for managing Shiny applications.
- **Packages**: Install the required libraries. Use:
  ```R
  install.packages(c(
    "shiny", "DT", "ggplot2", "plotly", "heatmaply", "treemap",
    "caret", "dplyr", "httr", "tidyr", "RSQLite", "digest",
    "shinyjs", "bslib", "googleAuthR", "waiter", "shinyWidgets"
  ))

# 📘 Usage
Login: Authenticate securely via Google OAuth.
Upload Data: Load your dataset through the interactive UI.
Explore Visualizations: Utilize various visualization tools for in-depth insights.
Apply Models: Perform machine learning tasks such as clustering and regression.
Export Results: Save insights and visualizations for further use.


# 🌟 Contributing
We welcome contributions! Feel free to submit issues or pull requests to improve InsightFlow.

