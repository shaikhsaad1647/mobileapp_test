# MobileApp Test

## Description

MobileApp Test is a Flutter-based mobile application designed for employee authentication and dashboard access. The app allows users to log in using their employee ID, verify their identity via a one-time password (OTP) sent to their email, and access a dashboard with key functions and announcements. The app features a clean, modern UI with a focus on usability and security.

### Key Features:
- **Employee ID Login**: Users can log in using a unique employee ID (format: `ABDS-12345`).
- **OTP Verification**: A 6-digit OTP is sent to the user's email for secure authentication.
- **Dashboard**: Displays user profile information, key functions (e.g., Request, Complaint, Salary Slip), and announcements.
- **Responsive Design**: The app is optimized for various screen sizes with a consistent UI.
- **State Management**: Uses the `GetX` package for efficient state management and navigation.

## Screenshots
![flow](https://github.com/user-attachments/assets/f26cb26a-654b-48d9-803b-a54e2a5b9e3a)


## Getting Started

### Prerequisites
- **Flutter SDK**: Ensure you have Flutter installed (version 3.0.0 or higher recommended). [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart**: Comes bundled with Flutter.
- **IDE**: Android Studio, VS Code, or any IDE with Flutter support.
- **Git**: To clone the repository.

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shaikhsaad1647/mobileapp_test/
   cd mobileapp-test
   ```

2. **Install Dependencies**:
   Run the following command to install the required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up Assets**:
   Ensure the `assets` directory contains the required images (e.g., `background.png`, `logo.png`, `profile.png`, etc.). Update the `pubspec.yaml` file to include the assets:
   ```yaml
   flutter:
     assets:
       - assets/images
   ```

4. **Run the App**:
   Connect a device or start an emulator, then run:
   ```bash
   flutter run
   ```

## Project Structure
```
mobileapp-test/
├── assets/                  # Static assets (images)
│   └── images/             # Contains all image assets (e.g., background.png, logo.png)
├── lib/                    # Source code for the app
│   ├── controllers/        # GetX controllers for state management
│   │   └── login_controller.dart
│   ├── views/             # UI screens of the app
│   │   ├── login_screen.dart
│   │   ├── otp_screen.dart
│   │   └── dashboard_screen.dart
│   ├── widgets/           # Reusable UI widgets
│   │   └── auth_screen_layout.dart
│   ├── helper/            # Utility classes and helpers
│   │   └── text_styles.dart
│   └── main.dart          # Entry point of the app
├── pubspec.yaml           # Dependencies and metadata
└── README.md              # Project documentation
```

## Dependencies
The app uses the following Flutter packages:
- `get: ^4.6.5` - For state management and navigation.
- `flutter_otp_text_field: ^1.1.1` - For OTP input field.

## Usage
1. **Login Screen**:
   - Enter your employee ID (e.g., `ABDS-12345`).
   - If the ID is valid, an OTP will be "sent" to the associated email (simulated via a snackbar for demo purposes).

2. **OTP Screen**:
   - Enter the 6-digit OTP shown in the snackbar.
   - If the OTP is incorrect, an error message appears, and you can resend the OTP after the timer expires.
   - If the OTP is correct, you’ll be redirected to the dashboard.

3. **Dashboard Screen**:
   - View your profile details (employee ID, name, email, company, platform).
   - Access key functions (e.g., Request, Complaint) in a grid layout.
   - Read the latest announcement.

## Demo Credentials
For testing purposes, use the following employee IDs:
- **Employee ID**: `ABDS-12345`
  - Email: `john.smith@albusayra.com`
- **Employee ID**: `ABDS-67890`
  - Email: `jane.doe@albusayra.com`

The OTP is displayed via a snackbar at the top of the screen when you attempt to log in or resend the OTP.

## Contributing
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For any inquiries, please reach out to [your-email@example.com](mailto:your-email@example.com).
