# Pearl Demo

A modern Flutter fintech app demo showcasing wallet, transfer, and payment features.

## Project Overview

Pearl is a cross-platform remittance application prototype built with Flutter, targeting Android, iOS, and Web platforms. The app facilitates seamless money transfers from developed countries to developing countries, offering multiple payout options and a user-friendly experience.

## Features

### Core Modules

- **Authentication**: User login, registration, and password reset flows
- **Profile & KYC**: User profile management and identity verification simulation
- **Payment Methods**: Credit card and bank account management
- **Recipient Management**: Address book for transfer recipients
- **Transfer Flow**: Complete money transfer workflow with currency conversion
- **Transaction History**: Past and pending transaction records
- **Wallet**: Digital wallet functionality
- **Notifications**: Simulated push notifications for key events

### Technical Stack

- **Framework**: Flutter 3.29.3
- **State Management**: Provider
- **Navigation**: GoRouter
- **UI Components**: Material Design with custom theming
- **Platforms**: Android, iOS, Web

## Getting Started

### Prerequisites

- Flutter SDK 3.7.2 or higher
- Dart SDK
- Android Studio / VS Code
- Chrome (for web development)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/christianwalt/Pearl-Demo.git
   cd Pearl-Demo
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile (with device/emulator connected)
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
│   ├── auth_provider.dart
│   └── user_provider.dart
├── screens/                 # UI screens
│   ├── auth/               # Authentication screens
│   ├── home/               # Home dashboard
│   ├── profile/            # Profile and KYC
│   ├── recipients/         # Recipient management
│   ├── transfer/           # Money transfer flow
│   ├── history/            # Transaction history
│   └── wallet/             # Wallet functionality
├── utils/                  # Utilities and themes
│   └── app_theme.dart
└── widgets/                # Reusable widgets
    └── bottom_navigation.dart
```

## Key Features Implemented

### 🏠 Home Dashboard
- Balance overview
- Quick action cards (Send Money, Add Money, Wallet)
- Recent transactions
- Modern, intuitive UI

### 💳 Wallet Integration
- Digital wallet interface
- Add money functionality
- Transaction history
- Balance management

### 👤 Profile Management
- User profile editing
- KYC verification simulation
- Payment methods management
- Security settings

### 💸 Transfer System
- Recipient selection
- Amount input with currency conversion
- Fee calculation
- Transfer confirmation

### 📱 Responsive Design
- Cross-platform compatibility
- Material Design principles
- Consistent theming
- Mobile-first approach

## Demo Data

The app uses simulated data and mock services for demonstration purposes. No real payment processing or backend integration is included.

## Contributing

This is a demo project showcasing Flutter development capabilities. Feel free to explore the code and use it as a reference for your own projects.

## License

This project is for demonstration purposes only.