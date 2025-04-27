# book_nest

## Overview
this is Book Nest app! , mobile app to help users to find interesting books 

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK installed (version 3.27.1 or higher).
- Dart SDK installed.
- An IDE such as Android Studio or VS Code with Flutter plugins installed.
- Used libraries :
      cached_network_image,dartz,dio,equatable,go_router,shared_preferences

## Getting Started

Follow the steps below to get the project up and running on your local machine for development and testing.

### 1. Clone the repository

git clone https://github.com/samahussien/book_nest.git

### 2.  Install dependencies

flutter pub get

### 3. Run Application

flutter run


## Used Libraries:

1. cached_network_image: ^3.4.1
The cached_network_image package is used for loading and caching images from the network. It helps improve the app's performance by reducing the number of network requests required to load images, storing images in memory or on disk for future use.

2.dartz: ^0.10.1
The dartz package brings functional programming utilities to Dart. It includes types like Option, Either, and other functional constructs that help handle null safety and write declarative, more predictable code.

3.dio: ^5.8.0+1
dio is a powerful HTTP client for making network requests. It provides advanced features such as request cancellation, interceptors, file downloading, and more, making it a versatile option for handling HTTP communication.

4.equatable: ^2.0.7
The equatable package simplifies value comparisons in Dart. It is primarily used to reduce boilerplate code when working with classes that need to be compared based on their values rather than their references. This is particularly helpful in state management and for comparing objects in Flutter.

5.flutter_bloc: ^9.1.0
flutter_bloc is used for managing app state using the BLoC (Business Logic Component) pattern. It helps separate business logic from UI components, making the code more modular, testable, and scalable.

6.go_router: ^15.1.1
go_router provides a declarative approach to routing in Flutter apps. It enables clean, maintainable, and flexible routing, supporting features such as nested routes, route transitions, and deep linking.

7.shared_preferences: ^2.5.3
The shared_preferences package is used for storing simple key-value pairs locally on the device. It is commonly used for saving user preferences, settings, or app state that needs to persist across app launches.


## notes
1. bonus is done: offline caching is done using shared_preferences package for books list , search books list and favorite books list 
2. additional feature is done: favorite list is done , so user can have his own customized favorite books list and also it's implemented for offline caching 


