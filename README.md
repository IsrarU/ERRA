# ERRA: Emergency Rapid Response Application

A cross-platform mobile application built with Flutter that helps people reach
help quickly in an emergency. It was developed as a BSCS Final Year Project at
the Institute of Computing, Kohat University of Science and Technology (KUST), 2023.

## Problem

People face threats such as harassment, domestic abuse, robbery and medical
emergencies. Existing safety apps mostly record incidents after they happen.
ERRA focuses on getting help to the user as fast as possible, with the fewest
steps.

## Features

- **SOS alert:** Shake the phone or press the in-app emergency button to send
  an SOS message with live location to saved family contacts and the nearest
  police station.
- **Emergency contacts:** Add and manage trusted contact numbers.
- **Missing person finder:** Report a missing family member so the report can
  be shared and the person located.
- **Complaints:** Submit complaints about harassment, violence or abuse to the
  concerned authorities.
- **User accounts:** Sign up and sign in.
- **Notifications:** Push notification support.

## Tech stack

| Area | Tools |
|---|---|
| Framework | Flutter, Dart |
| Backend / auth | Firebase |
| Databases | MySQL, SQLite (sqflite) |
| IDE / testing | Android Studio, VS Code, Android Emulator / physical device |

## Methodology

Developed using the **incremental model**: the system was divided into modules
(authentication, contacts, SOS, missing person, complaints), and each module
went through design, implementation and testing before the next was added.

## Screenshots

| Home | SOS / Contacts | Missing Person | Complaint |
|---|---|---|---|
| ![Home](screenshots/home.png) | ![SOS](screenshots/sos.png) | ![Missing](screenshots/missing.png) | ![Complaint](screenshots/complaint.png) |

## Getting started

## Project structure

- `main.dart`, `splash_screen.dart`: app entry and launch screen
- `sign_in_5.dart`, `signup.dart`: authentication
- `AddContact.dart`, `ShowContact.dart`: emergency contacts
- `AddMissingPerson.dart`, `MissingPersonList.dart`: missing person module
- `AddComplaint.dart`, `ComplaintList.dart`: complaint module
- `DbHelper.dart`: local database helper
- `notification_services.dart`: notifications

## Team and supervision

- Muhammad Israr Ul Haq ([Team Leader, Mangning OverallProject development, database])
- Abdul Samad Desinging
- Muhammad Talha Front End
- Supervisor: Dr. Muhammad Muneer Umar, Institute of Computing, KUST

## Limitations and future work

- Add automatic audio or sensor-based distress detection.
- Add an admin panel for authorities to track and resolve complaints.
- Add offline SMS fallback for areas with poor internet.

## License

[## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.]
1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. Clone the repository:
