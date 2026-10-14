# TaskFlow

A To-Do List mobile application built with Flutter, GetX, and MVC architecture.

## Features

- User Registration and Login
- Add, Edit, Delete Tasks
- Mark tasks as Completed or Pending
- Search tasks by title
- Filter: All / Pending / Completed
- Sort by Priority or Due Date
- Priority levels: Low, Medium, High
- Live stats: Total, Done, Active

## Tech Stack

- Flutter
- Dart
- GetX (State Management & Navigation)
- SQLite (Local Database)
- SHA-256 (Password Hashing)

## Project Structure

```
lib/
├── main.dart
├── app/
│   ├── routes/
│   ├── bindings/
│   └── constants/
├── data/
│   ├── models/
│   └── services/
├── modules/
│   ├── auth/
│   ├── home/
│   └── tasks/
└── shared/
    └── widgets/
```

## How to Run

```bash
flutter pub get
flutter run
```

