# Explore Fashion App

A stylish and simple fashion outfit mobile application built with Flutter and Node.js.
Users can discover popular outfits, publish their own outfits, and manage their collections easily.

## Tech Stack

**Client (Mobile App):**

* [Flutter](https://flutter.dev/) - Cross-platform UI toolkit
* [Dio]() - HTTP networking
* [GetX]() - State management, routing, dependency injection
* [Flutter ScreenUtil]() - Responsive design
* [Flutter Localizations (l10n)]() - Multi-language support

**Server (Backend):**

* [Node.js](https://nodejs.org/) - JavaScript runtime environment
* [Express](https://expressjs.com/) - Web framework for Node.js
* [MySQL](https://www.mysql.com/) - Relational database for storing user and outfit data

## App Features

1. **Authentication:**
   * Login using username and password
   * Register with username, email, and password
2. **Home Page:**
   * Search outfits
   * View a list of popular outfits
   * Button to publish a new outfit
3. **Profile Page:**
   * View user info (avatar, username, email)
   * Buttons for "My Favorites" and "Publish History"
4. **Publish Outfit:**
   * Take photos using the device camera
   * Edit outfit name, description, and type
   * Upload to server
5. **My Favorites:**
   * View a list of favorite outfits
6. **Publish History:**
   * View a list of outfits published by the user

## Database

* Use MySQL to create necessary tables for:
* user (username, email, password)
* outfit (user\_id, name, description, category, picture)
* favorite (user\_id, outfit\_id)
* record (user\_id, outfit\_id)

## Future Improvements

* Add social community
* Outfit categories and tags
* Comment features on outfits

## Flow Charts

````mermaid
graph
  A[launcher] --> B{auth state}
  B -->|login| C[to home page]
  B -->|register| D[input username email password]
  
  C --> F[bottom navigation]
  F --> G[home]
  F --> H[profile]
````

````mermaid
graph
  subgraph Home flow chart
  G[home]
  G --> I[record outfit]
  I --> J[to record page]--> K{is publish}
  K --> |publish record| L[edit name description category] --> M[upload]
  K --> |cancel| N[exit]
  G --> O[recommendation outfit]
  G --> R[search by key] --> Y[show search result]
  end
````

````mermaid
graph
  subgraph Personal center flow chart
  H[profile]
  H --> P[personal info]
  P --> V[user avatar]
  P  --> W[username]
  P  --> X[email]
  H --> Q[my favorite]
  Q --> S[show favorite list]
  H --> T[publish history]
  T --> U[show publish history list]
  end
````
