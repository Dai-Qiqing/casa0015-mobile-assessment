# 👗 Explore Fashion App

This App is a mobile application designed to empower users to rediscover personal fashion inspiration in an algorithm-dominated world.The app allows users to capture real-world outfit inspirations, organize and curate their favorite styles, and seamlessly manage their fashion collections.With a clean and intuitive design, the App creates a stylish, emotionally engaging experience that helps users express individuality and build their unique fashion journey.

## 🛠️ Tech Stack

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

## 🚀 Install Process

#### 1. Clone the Repository
#### 2. Install Flutter Dependencies (Client side)
cd client
flutter pub get
#### 3. Install Node.js Dependencies (Server side)
cd ../server
npm install
#### 4. Environment Setup
Make sure you have:
Flutter 3.27.1

Node.js 23

MySQL Server
#### 5. Database Setup
Create a MySQL database fashion_outfit_db.

Update /server/config/db.js with your database credentials.
#### 6. Configure API Base URL in Flutter App
 * Make sure your Flutter app points to the correct server IP address, not localhost.
 * Update the API base URL in your Flutter project (e.g., in a constants file or network configuration file).
 * Use your local IP address (e.g., 192.168.1.xxx) so the mobile device and the server are on the same network.
   Example：const String BASE_URL = "http://192.168.1.xxx:PORT";
 * Ensure both the computer (server) and the mobile device (client) are connected to the same Wi-Fi network.
#### 7. Database Setup
cd ../client
flutter run
#### 7.Run the Node.js Server (Backend)
cd ../server
npm start

## ✨ App Features

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

## Storyboard

![Storyboard](https://github.com/user-attachments/assets/6853700d-c16b-4a68-a86f-ddd6c810ad95)

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
