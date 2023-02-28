# Shop App 

## Introduction:

    - Shop App is a mobile application developed using Flutter framework and Dart programming language. 
It provides an easy and intuitive way for users to shop online for various products. The application utilizes Restful API **Dio package** for making API calls to the backend server 
and **Shared Preferences** for saving user data locally. **BLoC** architecture is used as a state management system to ensure the scalability and maintainability of the application. 
The following documentation explains how to setup and use the application.

##Prerequisites:

- Familiarity with Flutter and Dart programming concepts .
- Familiarity with the **dio** package for handling APIs .
- Familiarity with the **BLoC** pattern for state management . 
- Familiarity with the **SharedPreferences** package for storing user preferences .


## Installation

1. Clone or download the repository .
2. Install Dependencies:
    - Open the project in your preferred IDE and run the following command in the terminal:
        ```
        flutter pub get
        ```
3. Connect a physical device or launch an emulator .
4. Run the app .
5. Explore the application:
    Once the application is running, you can explore the various screens of the application. The application has five screens: Home, Categories, Favorites, Cart and Settings.
    ### Home Screen:
          - The home screen displays new products and a carousel slider for banners. 
          - Users can scroll through the products and tap on favorites and cart icons to put them in favorites and cart screens .

    ### Categories Screen:
          - The categories screen displays a list of product categories. Users can tap on a category to view products related to that category.

    ### Favorites Screen:
          - The favorites screen displays a list of favorite products. Users can add or remove products from their favorites list.

    ### Cart Screen:
          - The cart screen displays a list of products that have been added to the cart. Users can increase or decrease the quantity of products in the cart or remove them from the cart.
          - Users can pay with thier bank card .
     
    ### Settings Screen:
          - The settings screen allows users to update their personal information and log out of the application.

    ### Search:
          - The application also has a search Icon in the app bar that allows users to search for specific products.

    ### Payment Gateway:
          - The application supports a payment gateway that allows users to pay with any type of card.
          - The payment gateway is based on the APIs provided by the backend server **Check out**.

## Architecture

- The Shop App follows the **BLoC** architecture for state management. **BLoC** stands for Business Logic Component, which is responsible for managing the state of the application. The **BLoC** pattern ensures that the application is scalable and maintainable by separating the business logic from the user interface.

## Data Persistence

- The Shop App uses **Shared Preferences** for local data persistence. **Shared Preferences** is a key-value store that allows the application to save small amounts of data locally on the device. The application uses **Shared Preferences** to save the user's authentication token after they have logged in. This token is used for subsequent API calls to the backend server.

## Restful API

-The Shop App uses Restful API calls to communicate with the backend server. The application utilizes the **Dio package** for making HTTP requests to the server. The API endpoints are defined in the endpoints.dart file. The application makes use of asynchronous programming techniques to handle the response from the server. 
          
