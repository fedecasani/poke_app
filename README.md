# Pokémon Application

## Description

This Flutter application allows users to explore a list of Pokémon using the [PokeAPI](https://pokeapi.co/). The app is designed with clean architecture and utilizes Riverpod for state management. It offers an attractive and functional user interface, with the ability to toggle between light and dark modes.

## Characteristics

- Display of a list of Pokémon with names and images.
- Navigation to a Pokémon detail screen upon selecting an item from the list.
- Infinite loading of Pokémon as the user scrolls down.
- Toggle between light and dark mode.

## Technologies Used

- Flutter
- Dart
- Riverpod
- Dio (for HTTP requests)
- Mockito (for testing)
- Flutter Test (for unit testing)

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/fedecasani/poke_app.git
   cd poke_app
   ```

2. **Install the dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   ```bash
   flutter run
   ```

## Project Structure

- **lib/**
  - **data/**
    - **datasources/**: Remote and local data sources.
    - **models/**: Data models.
    - **repositories/**: Repository implementations.
  - **domain/**
    - **entities/**: Business entities.
    - **repositories/**: Repository interfaces.
    - **usecases/**: Use cases.
  - **presentation/**
    - **providers/**: Riverpod state providers.
    - **screens/**: Application screens.
    - **widgets/**: WCustom widgets.
  - **core/**
    - **errors/**
    - **usecases/**
  - **main.dart**: ntry point of the application.
  

## Usage

1. When you open the application, a list of Pokémon will be displayed.
2. Scroll down to load more Pokémon.
3. Tap a Pokémon to view its details.
4. Use the dropdown menu to toggle between light and dark mode.


## Tests

The application includes unit tests to verify the functionality of the main features. You can run the tests using:

```bash
flutter test
```

### Example Tests

- **Pokémon Loading Test:** Verifies that a list of Pokémon is displayed when the data is loaded correctly.
- **Loading Indicator:** Ensures that a loading indicator is shown while data is being fetched.

```dart
testWidgets('should display a list of Pokémon when data is loaded', (WidgetTester tester) async {
  // Configuración de prueba...
});
```

## Contributions

Contributions are welcome. If you would like to contribute, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
