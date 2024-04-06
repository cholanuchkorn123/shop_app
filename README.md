# Flutter Shop App

This Flutter project is a shop app that allows users to browse, save, delete, and add items to their cart. It follows the principles of clean architecture for design patterns and utilizes Riverpod for state management. Unit tests are implemented using Mockito, and code generation is handled with build_runner. For local database storage, the app utilizes Hive.

## Features

- Browse items
- Save items
- Delete items
- Add items to cart

## Architecture

The project follows clean architecture principles, separating the app into distinct layers:

1. **Presentation**: UI components, screens, and widgets reside here.
2. **Domain**: Business logic and domain models.
3. **Data**: Repository implementations, data sources, and API communication.

## State Management

[Riverpod](https://pub.dev/packages/riverpod) is used for state management. It's a provider package that makes it easy to handle and observe changes in app state.

## Unit Testing

Unit tests are implemented using [Mockito](https://pub.dev/packages/mockito) for mocking dependencies and ensuring the correctness of individual units of code.

## Code Generation

[build_runner](https://pub.dev/packages/build_runner) is used for code generation tasks like generating serializers, type adapters, and other boilerplate code.

## Local Database

[Hive](https://pub.dev/packages/hive) is utilized for local database storage. It's a lightweight and fast key-value database suitable for mobile and web applications.

## Getting Started

To get started with the project:

1. Clone this repository.
2. Install dependencies by running:

```
flutter pub get
```
```
flutter pub run build_runner build
```

To run unit tests:

```
flutter test
```
