# Cognitia AI

A full-stack Conversational AI web application powered by Groq and MongoDB Atlas.

## Project Overview

Cognitia AI accepts a single user question, sends it to the Groq API (llama-3.1-8b-instant model), displays the AI-generated answer, and stores both the question and answer in MongoDB Atlas. Each interaction is stateless — no conversation history is maintained.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 19, Vite, Axios |
| Backend | Node.js, Express.js |
| AI Model | Groq API — `llama-3.1-8b-instant` |
| Database | MongoDB Atlas (Mongoose) |
| Deployment | Vercel (frontend + backend, independent projects) |

## Folder Structure

```
cognitia-AI/
├── frontend/              # React + Vite client
│   ├── src/
│   │   ├── App.jsx        # Main UI component
│   │   ├── App.css        # Styles
│   │   └── main.jsx       # Entry point
│   ├── public/            # Static assets
│   ├── vercel.json        # Vercel SPA routing config
│   └── .env.example
├── backend/               # Express.js API server
│   ├── config/db.js       # MongoDB connection
│   ├── controllers/       # Request handlers
│   ├── models/Chat.js     # Mongoose schema
│   ├── routes/            # API routes
│   ├── server.js          # Entry point
│   ├── vercel.json        # Vercel serverless config
│   └── .env.example
├── README.md
└── vibecoded.md           # AI tools documentation
```

## API Usage

### POST /api/ask

**Request:**
```json
{
  "question": "What is Bitcoin?"
}
```

**Response:**
```json
{
  "answer": "Bitcoin is a decentralized digital currency..."
}
```

**Error Response:**
```json
{
  "error": "Question is required"
}
```

## Setup Instructions (Local)

### Prerequisites
- Node.js v18+
- MongoDB Atlas account (free tier)
- Groq API key (free at console.groq.com)

### Backend
```bash
cd backend
cp .env.example .env
# Fill in GROQ_API_KEY, MONGODB_URI, FRONTEND_URL in .env
npm install
npm run dev
# Runs on http://localhost:5000
```

### Frontend
```bash
cd frontend
cp .env.example .env
# Set VITE_API_URL=http://localhost:5000
npm install
npm run dev
# Runs on http://localhost:5173
```

### Environment Variables

**backend/.env**
```
GROQ_API_KEY=your_groq_api_key
MONGODB_URI=mongodb+srv://...
PORT=5000
FRONTEND_URL=http://localhost:5173
```

**frontend/.env**
```
VITE_API_URL=http://localhost:5000
```

## Deployment (Vercel)

Both frontend and backend are deployed as **separate Vercel projects** from the same GitHub repository.

### Step 1 — Push to GitHub
```bash
git add .
git commit -m "ready for deployment"
git push origin main
```

### Step 2 — Deploy Backend
1. Go to [vercel.com](https://vercel.com) → **Add New Project**
2. Import the same GitHub repository
3. Set **Root Directory** to `backend`
4. Add environment variables:
   - `GROQ_API_KEY` → your Groq key
   - `MONGODB_URI` → your Atlas connection string
   - `FRONTEND_URL` → *(leave blank for now, update after frontend deploys)*
5. Click **Deploy** → copy the backend URL (e.g. `https://cognitia-backend.vercel.app`)

### Step 3 — Deploy Frontend
1. Go to Vercel → **Add New Project** → same repo
2. Set **Root Directory** to `frontend`
3. Add environment variable:
   - `VITE_API_URL` → your backend URL from Step 2
4. Click **Deploy** → copy the frontend URL

### Step 4 — Update Backend CORS
1. Go to backend project in Vercel → Settings → Environment Variables
2. Set `FRONTEND_URL` to your frontend URL from Step 3
3. **Redeploy** the backend

## Security Practices

- API keys stored in environment variables only (never in code)
- CORS restricted to the deployed frontend URL via `FRONTEND_URL` env var
- Input validation on backend (empty/short queries rejected)
- `.env` files excluded from git via `.gitignore`

## License

MIT
