# 🌿 HabitPulse — Daily Habit Tracker

A modern, high-performance **Daily Habit Tracker** built in **Flutter** using **Clean Architecture**, **Firebase Cloud Firestore**, and **BLoC** state management. Designed with an ultra-sleek emerald green gradient aesthetic, micro-animations, real-time sync, and comprehensive **7-day streak** visualization.

---

## 📱 Table of Contents
1. [Overview & Features](#-overview--features)
2. [Screen-by-Screen Breakdown](#-screen-by-screen-breakdown)
3. [Clean Architecture Design](#-clean-architecture-design)
4. [Tech Stack & Package Justification](#-tech-stack--package-justification)
5. [Setup & Execution Guide](#-setup--execution-guide)
6. [Submission Artifacts (Notion / Google Doc Ready)](#-submission-artifacts)
   - [AI Tools & Prompts Used (3+ Examples)](#ai-prompts-used)
   - [AI Correction & Guidance Instance](#ai-correction--guidance-instance)
   - [Clean Architecture Verification Checklist](#clean-architecture-verification)
   - [2-3 Minute Vibe Coding Video Script](#vibe-coding-walkthrough-script)

---

## 🌟 Overview & Features

- **Daily Habit Management**: Create, track, and complete habits effortlessly.
- **Points & Gamification**: Each habit awards a custom point value (e.g. 10, 15, 20 pts). Points accumulate dynamically as habits are completed.
- **7-Day Streak Visualization**: An interactive, visual 7-day strip showcasing your consistency over the last week with glowing checkmarks.
- **Real-Time Firebase Firestore Integration**: Direct Cloud Firestore synchronization using real-time snapshots with offline fallback resilience.
- **Emerald Theme & Micro-Animations**: Rich gradients, tactile haptic feedback, subtle animations, and modern typography powered by Google Fonts.

---

## 🖥️ Screen-by-Screen Breakdown

### Screen 1: Today's Habits (`/`)
- **Today's Overview Header**:
  - Displays today's date (e.g. "Sunday, Oct 18").
  - Real-time counter of **total points earned today** with a gold trophy badge.
  - Interactive **circular progress ring** showing completion ratio (e.g. `60%`, `3 of 5 habits completed`).
  - Dynamic motivational feedback quote.
- **Habit List Items**:
  - Habit Title & Description.
  - Category pill with custom color and icon (💧 Health, 🏋️ Fitness, 📚 Learning, 🧘 Mindfulness, ⚡ Productivity).
  - Points badge (`+15 pts`).
  - Current active streak counter (`🔥 3d streak`).
  - **Tappable Done/Undone Checkbox**: Smooth animated toggle with haptic feedback updating points and state instantly.
  - Tap card to navigate directly to Screen 3 (Habit Detail).
- **Navigation to Add Habit**:
  - Prominent Floating Action Button (FAB) with emerald gradient and plus icon.

### Screen 2: Add Habit (`/add`)
- **Form Fields**:
  - **Habit Name** (e.g., "Drink 2L Water", "Read 20 Pages") with validation.
  - **Description / Motivation** (e.g., "Peak cognitive performance & energy").
  - **Category Selector**: Horizontal scroll chips with custom icons and themes.
  - **Points Value**: Quick preset chips (`+5`, `+10`, `+15`, `+20`, `+25`, `+50 pts`) + custom numeric input.
- **Form Validation & Action**:
  - Validates required title and positive points value.
  - "Save Habit" button with loading indicator.
  - Automatically navigates back with an emerald success notification toast.

### Screen 3: Habit Detail (`/detail/:id`)
- **Habit Metadata**:
  - Title, description, category badge, and points per day.
- **7-Day Streak Visualization**:
  - Sleek streak banner displaying current continuous streak (`🔥 X Day Streak`) and 7-day consistency rate (`XX%`).
  - **Interactive 7-Day Calendar Strip**: Shows the last 7 days (day name e.g. Mon, day number e.g. 18, and status bubble). Completed days glow with emerald checkmarks. Tapping any past day toggles its status!
- **Lifetime Statistics**:
  - Total days completed all-time.
  - Total points earned from this habit.
- **Interactive Action Button**:
  - Large button: "Mark Today as Done (+X pts)" with vibrant green gradient.
  - Toggles to "Done Today! Tap to Undo" when completed.
- **Delete Habit**:
  - Safe deletion action with confirmation dialog.

---

## 🏛️ Clean Architecture Design

The project is structured according to **Uncle Bob's Clean Architecture**, enforcing strict separation of concerns, dependency inversion, and business logic isolation:

```
lib/
├── core/                           # Cross-cutting concerns & shared infrastructure
│   ├── constants/                  # Design tokens: AppColors, AppTypography, AppDimens
│   ├── errors/                     # Failure and Exception hierarchies
│   ├── usecases/                   # Generic UseCase<T, Params> & StreamUseCase<T, Params>
│   ├── utils/                      # HabitDateUtils (Streak calculation, ISO formatters)
│   └── di/                         # Service locator setup with GetIt
│
├── domain/                         # Pure business logic (Independent of UI & external DB)
│   ├── entities/                   # Habit, DayStreakInfo, Freezed StreakSummary
│   ├── repositories/               # HabitRepository (contract using Dartz Either)
│   └── usecases/                   # GetHabitsStream, AddHabit, ToggleHabit, DeleteHabit
│
├── data/                           # Data manipulation & external integrations
│   ├── models/                     # HabitModel (Firestore & JSON serialization)
│   ├── datasources/                # HabitRemoteDataSource (Cloud Firestore & reactive cache)
│   └── repositories/               # HabitRepositoryImpl (implements HabitRepository)
│
└── presentation/                   # UI & State Management
    ├── bloc/                       # HabitBloc, HabitEvent, HabitState (flutter_bloc)
    ├── router/                     # GoRouter configuration ('/', '/add', '/detail/:id')
    ├── screens/                    # TodayHabitsScreen, AddHabitScreen, HabitDetailScreen
    └── widgets/                    # DailyProgressHeader, HabitListItem, StreakCalendarBar
```

### Dependency Inversion Flow:
$$\text{Presentation Layer (UI / BLoC)} \longrightarrow \text{Domain Layer (Use Cases / Entities)} \longleftarrow \text{Data Layer (Repositories / Firestore)}$$

- The **Domain layer** has **zero** dependencies on Flutter UI or Firebase packages.
- All use case operations return `Either<Failure, T>` from `dartz` to guarantee functional, crash-free error handling.
- Firestore atomic operators (`FieldValue.arrayUnion`, `FieldValue.arrayRemove`) are encapsulated within `HabitRemoteDataSource`.

---

## 📦 Tech Stack & Package Justification

| Package | Version | Purpose in this Project |
| :--- | :--- | :--- |
| **`flutter_bloc`** | `^9.1.1` | Predictable, reactive state management decoupling UI from domain logic. |
| **`cloud_firestore`** | `^7.0.0` | Real-time NoSQL cloud database for instant multi-device habit updates. |
| **`firebase_core`** | `^5.0.0` | Firebase app initialization and platform coordination. |
| **`freezed` / `freezed_annotation`**| `^4.0.3` | Immutable value objects, copyWith, and code generation. |
| **`dartz`** | `^0.10.1` | Functional programming utilities (`Either<Failure, T>`) for error handling. |
| **`get_it`** | `^9.3.0` | Service Locator for dependency injection across architectural layers. |
| **`go_router`** | `^18.1.0` | Declarative routing with deep linking and path parameter support. |
| **`google_fonts`** | `^9.0.0` | High-aesthetic typography (`Outfit` for titles, `Plus Jakarta Sans` for body). |
| **`intl`** | `^0.20.3` | Internationalized date formatting and ISO string conversions. |

---

## 🚀 Setup & Execution Guide

### Prerequisites
- Flutter SDK `^3.13.0` (Tested on Flutter 3.47.0)
- Dart SDK `^3.13.0`

### 1. Clone & Install Dependencies
```bash
git clone https://github.com/abdul7860924928/daily_habit_tracker.git
cd daily_habit_tracker
flutter pub get
```

### 2. Run Tests & Code Quality Verification
```bash
# Run domain & streak logic unit tests
flutter test

# Run static analysis (0 warnings / 0 errors)
flutter analyze
```

### 3. Launch the Application
```bash
# Run on Chrome
flutter run -d chrome

# Run on macOS Desktop
flutter run -d macos

# Run on iOS / Android Simulator
flutter run -d <emulator-id>
```

---

## 📝 Submission Artifacts

> **Copy and paste the sections below directly into your Notion page or Google Doc submission!**

---

### AI Prompts Used

Here are 3 detailed examples of prompts used while pair-programming with the AI to architect and implement this application:

#### Prompt 1: Architecture & Domain Modeling
> *"Design a clean architecture domain layer for a Flutter Daily Habit Tracker using `dartz` for functional error handling. The `Habit` entity must contain `id`, `name`, `description`, `points`, `completedDates` (List of ISO 'YYYY-MM-DD' strings), and `category`. Write use cases for `GetHabitsStreamUseCase`, `AddHabitUseCase`, and `ToggleHabitUseCase`. Ensure the domain layer has no dependencies on Flutter UI or Firebase packages."*

#### Prompt 2: Firestore Remote Data Source & Real-time Sync
> *"Implement `HabitRemoteDataSource` in Flutter using `cloud_firestore`. Use `snapshots()` to stream habits ordered by `createdAt`. When toggling a habit completion status for a given date, use atomic Firestore operations (`FieldValue.arrayUnion` to mark done, `FieldValue.arrayRemove` to mark undone). Also implement a graceful reactive fallback store so the UI operates seamlessly during development or offline preview."*

#### Prompt 3: Streak Calculation & 7-Day Visual UI Component
> *"Create a specialized utility `HabitDateUtils` and a custom Flutter widget `StreakCalendarBar` that visualizes a 7-day streak (the past 6 days up to today). For each day, display the short day name, day number, and an animated circular indicator that glows emerald green with a checkmark when completed. Add support for tapping any day to toggle its status."*

---

### AI Correction & Guidance Instance

#### The Problem:
During the initial generation of `HabitRemoteDataSourceImpl` and `HabitModel`, the AI attempted to import `cloud_firestore` directly inside the domain entity file `habit.dart` to use `Timestamp` for `createdAt`. Additionally, in the presentation layer (`habit_detail_screen.dart`), the AI provided a fallback dummy `Habit` inside `firstWhere` with `createdAt: null as dynamic`, which triggered a Dart `const_constructor_param_type_mismatch` compiler error.

#### The Correction & Guidance Given:
1. **Domain Isolation**: We directed the AI to keep `DateTime` as the pure Dart type inside `Habit` domain entity, keeping `Timestamp` conversion strictly isolated inside `HabitModel` within the Data layer (`HabitModel.fromFirestore` and `toFirestore()`).
2. **Null Safety Refactoring**: We guided the AI to replace the error-prone `firstWhere(..., orElse: () => dummyHabit)` with Dart's modern iterable extension:
   ```dart
   final habit = state.habits.where((h) => h.id == habitId).firstOrNull;
   if (habit == null) {
     return const HabitNotFoundView();
   }
   ```
3. **Typography Conflict Resolution**: When `GoogleFonts.plusJakartaSansTextTheme(Theme.of(context).textTheme)` encountered a type mismatch in Flutter 3.47, we corrected the implementation to set `fontFamily: GoogleFonts.plusJakartaSans().fontFamily` directly in `ThemeData`, providing universal font coverage without TextTheme instantiation issues.

---

### Clean Architecture Verification

To verify that the code strictly adheres to Clean Architecture rules:
1. **Independence of Domain**: Checked `lib/domain/` to verify that no imports from `package:flutter`, `package:cloud_firestore`, or `package:firebase_core` exist. Domain only contains pure Dart code, `dartz`, and `freezed_annotation`.
2. **Dependency Inversion**: High-level use cases depend on the abstract `HabitRepository` interface, never on `HabitRepositoryImpl` or `HabitRemoteDataSource`.
3. **Data Layer Decoupling**: `HabitRepositoryImpl` translates external `ServerException` into domain `ServerFailure` objects wrapped in `Either<Failure, T>`.
4. **Presentation Separation**: All widgets only dispatch events (`HabitToggled`, `HabitAdded`) to `HabitBloc` and listen to immutable `HabitState`. The UI contains zero direct database calls.

---

### Vibe Coding Walkthrough Script
*(Use this 2-3 minute script when recording your submission video)*

- **0:00 - 0:30 (Introduction & AI Tools)**:
  > *"Hi everyone! In this video, I'll walk you through my Daily Habit Tracker app built in Flutter with Clean Architecture and Firebase. For this project, I used AI pair-programming tools to accelerate development while maintaining strict architectural standards. I used the AI for domain design, BLoC state management, and crafting our custom emerald aesthetic."*

- **0:30 - 1:15 (Prompts & Architecture Setup)**:
  > *"I structured my prompts around Uncle Bob's Clean Architecture. First, I prompted the AI to model pure domain entities with `dartz` Either error handling. Then, I asked it to implement real-time Firestore integration using atomic operations like `arrayUnion` and `arrayRemove` for habit completions. Finally, we generated Freezed models and hooked everything up using GetIt for dependency injection and GoRouter for declarative routing."*

- **1:15 - 1:50 (Guiding and Correcting the AI)**:
  > *"A critical part of vibe coding is knowing when to correct the AI. At one point, the AI attempted to import Firestore's Timestamp into our domain entity. I intervened immediately to maintain strict Clean Architecture boundaries, keeping `Timestamp` inside the Data layer's `HabitModel` and using standard Dart `DateTime` in the Domain. I also refined the streak calculation logic to handle both today and yesterday transitions gracefully."*

- **1:50 - 2:30 (Live App Demo Walkthrough)**:
  > *"Now let's see the app in action! On Screen 1, we see 'Today's Habits' with our overview header displaying 35 earned points and a 60% completion ring. When I tap the checkbox on 'Exercise 30 Min', watch the points increment in real time with haptic feedback. Next, let's tap the '+' button to go to Screen 2. Here we create 'Morning Yoga', give it 20 points, pick the Fitness category, and save. It instantly syncs and appears on our list. When we tap into the habit, Screen 3 presents our 7-Day Streak visualization, complete with day-by-day checkmark bubbles and lifetime statistics. We can also toggle today's status right from this screen. Thank you for watching!"*

---

## 👨‍💻 Author & Repository
- **GitHub Repository**: [daily_habit_tracker](https://github.com/abdul7860924928/daily_habit_tracker)
- **Author**: [Abdul Raheem](https://github.com/abdul7860924928)
- Built with ❤️ using Flutter, Firebase & Clean Architecture
