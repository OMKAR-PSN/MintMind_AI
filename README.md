# 💸 MintMind AI

### **AI-Driven Personal Finance Chatbot — your money, explained in plain language**

---

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Python](https://img.shields.io/badge/Python_3.11-3776AB?style=flat-square&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![AI](https://img.shields.io/badge/AI--Powered-FF6F00?style=flat-square&logo=openai&logoColor=white)

---

## ✨ Features

- 🤖 **Conversational Finance AI** — Chat naturally about budgeting, savings, and spending — the AI responds with context-aware, personalized financial advice
- 📊 **Expense Tracking & Categorization** — Automatically categorizes user-entered transactions into spending buckets (Food, Rent, Entertainment, Savings)
- 💡 **Smart Spending Insights** — AI analyses monthly patterns and surfaces actionable suggestions like "You spent 40% more on dining this month"
- 📱 **Cross-Platform Flutter App** — Single codebase runs on Android, iOS, and Web with a polished, native-feeling UI
- 🔗 **FastAPI Backend** — Lightweight Python API handles AI inference, expense storage, and insight generation — decoupled from the mobile client
- 📁 **Local Data Persistence** — Uses Hive for offline-first local storage; finance data is never lost on disconnect

---

## 🧰 Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter 3.x, Dart |
| State Management | Riverpod |
| Local Storage | Hive |
| Backend API | FastAPI (Python 3.11) |
| AI / NLP | LLM API (Gemini / OpenAI) for chat, RAG for insights |
| Data Layer | SQLite (backend) + Hive (mobile) |
| Deployment | Render (backend), Play Store / Web (frontend) |

---

## 🏛️ Architecture

```
Flutter App (Mobile / Web)
  │── Chat screen         ← User sends finance queries
  │── Dashboard screen    ← Expense trends & AI insights
  │── Add Transaction     ← Manual expense entry
  │
  │  HTTP (Dio / http package)
  │
  ▼
FastAPI Backend (Python)
  │── POST /chat          ← AI chatbot response (LLM)
  │── POST /transaction   ← Store new expense entry
  │── GET  /insights      ← Monthly spending analysis
  │── GET  /categories    ← Expense category breakdown
  │
  ▼
AI Layer
  │── LLM (Gemini / GPT)  ← Natural language understanding
  │── RAG pipeline        ← Grounded advice from finance docs
  │
  ▼
Storage
  │── Hive (mobile)       ← Offline-first transaction cache
  └── SQLite (backend)    ← Persistent server-side records
```

---

## ⚙️ Local Setup

### Prerequisites
- Flutter SDK ≥ 3.x ([install guide](https://docs.flutter.dev/get-started/install))
- Dart ≥ 3.x
- Python ≥ 3.11
- pip

### 1. Clone the Repository

```bash
git clone https://github.com/OMKAR-PSN/MintMind_AI.git
cd MintMind_AI
```

### 2. Start the Backend

```bash
cd backend

# Install Python dependencies
pip install -r requirements.txt

# Configure environment (see below)
cp .env.example .env

# Start FastAPI server
uvicorn main:app --reload
```

Backend runs at `http://localhost:8000`.

#### Backend `.env` Variables

```env
GEMINI_API_KEY=your-gemini-api-key-here
DATABASE_URL=sqlite:///./mintmind.db
CORS_ORIGIN=http://localhost:3000
```

### 3. Start the Flutter App

```bash
cd frontend

# Get Flutter packages
flutter pub get

# Run on connected device / emulator
flutter run

# Or run on Chrome (web)
flutter run -d chrome
```

> Update the `baseUrl` in `frontend/lib/services/api_service.dart` to point to your backend URL.

---

## 📸 Screenshots

| Screen | Preview |
|---|---|
| Home Dashboard | *(screenshot)* |
| AI Chat Interface | *(screenshot)* |
| Add Transaction | *(screenshot)* |
| Spending Insights | *(screenshot)* |
| Category Breakdown | *(screenshot)* |

---

## 🚀 Deployment

| Layer | Platform |
|---|---|
| Backend API | [Render](https://render.com) (free tier) |
| Mobile App | Build APK via `flutter build apk` |
| Web App | `flutter build web` → deploy to Vercel / Netlify |

> ⚠️ If backend is on Render's free tier, first request may take **~30 seconds on cold start**.

---

## 👥 Team

| Name | Role | GitHub |
|---|---|---|
| Omkar | Full-Stack Developer | [@OMKAR-PSN](https://github.com/OMKAR-PSN) |


---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">
  <i>MintMind AI — because financial clarity shouldn't require a finance degree.</i>
</div>
