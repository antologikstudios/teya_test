# iTunes Teya Test

A Flutter application that displays iTunes albums with detailed information. This project was developed as a technical test for a job application, showcasing modern Flutter development practices, clean architecture, and comprehensive testing.

## 📱 Features

- **Album Listing**: Browse through a collection of iTunes albums
- **Album Details**: View detailed information about selected albums
- **Clean Architecture**: Organized code structure with separation of concerns
- **State Management**: GetX for efficient state management
- **Network Layer**: Dio for HTTP requests with proper error handling
- **Unit Testing**: Comprehensive test coverage with mocking

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── src/
│   ├── app_config/           # Application configuration
│   ├── data/                 # Data layer (models, repositories, services)
│   ├── modules/              # Feature modules
│   │   ├── album/           # Album listing feature
│   │   └── album_details/   # Album details feature
│   ├── routes/              # Navigation and routing
│   └── utils/               # Utilities and constants
└── main.dart                # Application entry point
```

## 🚀 Getting Started

### Prerequisites

Before running this application, make sure you have:

- **Flutter SDK** (3.10.0 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **Xcode** (for device/emulator)
- **VS Code** (recommended IDE)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/antologikstudios/teya_test.git
   cd teya_test
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

### Running the Application

#### Development Mode

```bash
flutter run
```

#### Specific Platform

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

```

#### Release Mode

```bash
flutter run --release
```

## 🧪 Testing

This project includes comprehensive unit tests to ensure code reliability.

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

## 📦 Dependencies

### Main Dependencies

- **flutter**: SDK framework
- **get**: State management and dependency injection
- **dio**: HTTP client for API requests
- **logger**: Logging utility
- **intl**: Internationalization support

### Development Dependencies

- **mockito**: Mocking library for tests

## 🔧 Project Configuration

### Environment Setup

The project uses Flutter SDK version `^3.10.0-227.0.dev`. Make sure your Flutter installation matches this requirement.

## 📁 Project Structure Details

### Data Layer

- **Models**: Data transfer objects
- **Services**: API communication layer
- **Repositories**: Data access abstraction

### Presentation Layer

- **Modules**: Feature-based organization
- **Controllers**: GetX controllers for state management
- **Views**: UI components and screens

### Configuration

- **Routes**: Application navigation setup
- **Bindings**: Dependency injection configuration
- **Constants**: Application-wide constants

## 🎯 Key Implementation Highlights

1. **GetX State Management**: Efficient and reactive state management
2. **Clean Architecture**: Separation of concerns with clear boundaries
3. **Error Handling**: Comprehensive error handling throughout the app
4. **Testing Strategy**: Unit tests with mocking for reliable code
5. **Network Layer**: Robust HTTP client with interceptors
6. **Date Formatting**: Proper date handling and formatting

## 👤 Author

**Fabio Cataldo**

- GitHub: [@antologikstudios](https://github.com/antologikstudios)

## 📄 License

This project is created for technical assessment purposes.

---

**Note**: This application was developed as part of a technical assessment for Teya. It demonstrates proficiency in Flutter development, clean architecture implementation, and modern mobile app development practices.
