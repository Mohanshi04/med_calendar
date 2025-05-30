# Med Calendar – Medication Tracking App

A Flutter-based calendar application that displays a user's daily medication intake using color coding. The intake data is fetched from an external API and used to highlight calendar days accordingly.

## Features

- Interactive calendar built using `table_calendar`.
- Live API integration to fetch medication intake history.
- Color-coded days based on dosage:
  - Green for 100mg intake
  - Yellow for 50mg intake
  - Red for 0mg (no medication taken)
- Automatically updates the calendar UI when data is loaded.

## Dependencies

Managed via `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  table_calendar: ^3.0.9
  intl: ^0.18.1
```

## Getting Started

### Prerequisites

- Flutter SDK installed  
  Refer to the [Flutter installation guide](https://flutter.dev/docs/get-started/install) for setup instructions.
- Git installed for cloning the repository
- A device or emulator to run the app

### Installation

1. Clone the Repository  
   ```bash
   git clone https://github.com/Mohanshi04/med_calendar.git
   cd med_calendar
   ```

2. Install Dependencies  
   ```bash
   flutter pub get
   ```

3. Run the App  
   ```bash
   flutter run
   ```

## API Format

The app expects the API to return JSON in the following format:

```json
{
  "intake_history": [
    { "date": "01/05/2025", "dose": 100 },
    { "date": "02/05/2025", "dose": 50 },
    { "date": "03/05/2025", "dose": 0 },
    { "date": "04/05/2025", "dose": 100 }
  ]
}
```

## Project Structure

```
med_calendar/
├── lib/
│   └── main.dart
├── pubspec.yaml
├── README.md
```
