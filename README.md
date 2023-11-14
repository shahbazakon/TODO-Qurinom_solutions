# Qurinom Solutions DoneIt 📝



## About

It simply loads **Notes** data from in memory database. Notes will be always loaded from in memor database.

- This makes it offline capable 😃.
- Clean and Simple Material UI.
- It supports dark theme too 🌗.

## Directory Structure

    .
    ├── core                       # For all common and core files.
    │   ├── error                  # contains all Exceptions and Failures classes
    │   ├── presentation           # common presentation files
    |   │   └── blocs              # common blocs
    |   │   └── pages              # core pages
    |   │   └── widgets            # common widgets
    │   └── route                  # Routes for navigation
    │   └── theme                  # Theme data
    │   └── usecases               # common usecases
    |
    ├── feature                    # all features
        ├── feature1               # Feature 1 (for exp : Todo Feature)
            ├── data               # Data Files of Feature 1
            ├   └── datasources    # DataSources Abstract Files and Implementations
            ├   └── models         # Models for data
            ├   └── repositories   # Repositories Implementation Classes
            └── domain             # Domain
            ├   └── entities       # Entities For Feature 1
            ├   └── usecases       # Usecases of Feature 1
            ├   └── repositories   #   Repositories Abstract Classes
            ├── presentation       # Feature 1 presentation files
            │   └── blocs          # Feature 1 blocs
            │   └── pages          # Feature 1 pages
            │   └── widgets        # Feature 1 widgets

