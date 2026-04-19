# Cognitia AI

A full-stack Conversational AI web application powered by Groq and MongoDB.

## Project Overview

Cognitia AI is a single-question, single-answer AI chatbot application. Users ask one question and receive one AI-generated response. Every question is processed as a fresh request with no conversation memory.

## Tech Stack

### Frontend
- React (Vite)
- Axios
- CSS (Custom glassmorphism design)
- Typewriter animations

### Backend
- Node.js
- Express.js
- Groq SDK (llama-3.1-8b-instant model)
- MongoDB Atlas (Mongoose)

### Deployment
- Frontend: Vercel
- Backend: Vercel (or similar)

## Folder Structure

```
/frontend           # React + Vite application
/backend            # Express.js API server
  /config          # Database configuration
  /controllers     # Request handlers
  /models           # Mongoose schemas
  /routes          # API routes
  server.js        # Entry point
README.md          # This file
vibecoded.md       # AI tools documentation
```

## API Usage

### POST /api/ask

Ask a question to the AI.

**Request:**
```json
{
  "question": "What is Java?"
}
```

**Response:**
```json
{
  "answer": "Java is..."
}
```

## Setup Instructions

### Prerequisites
- Node.js (v18+)
- MongoDB Atlas account
- Groq API key

### Backend Setup
```bash
cd backend
cp .env.example .env
# Edit .env with your GROQ_API_KEY and MONGODB_URI
npm run dev
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### Environment Variables

**Backend (.env):**
```
GROQ_API_KEY=your_groq_api_key
MONGODB_URI=your_mongodb_uri
PORT=5000
```

**Frontend (.env):**
```
VITE_API_URL=http://localhost:5000
```

## Deployment

### Backend (Vercel)
1. Push code to GitHub
2. Import project in Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

### Frontend (Vercel)
1. Push code to GitHub
2. Import project in Vercel
3. Add `VITE_API_URL` environment variable (your backend URL)
4. Deploy

## Features

- Single question → single answer
- No conversation memory
- Typewriter text animation
- Rotating input placeholder
- Glassmorphism UI design
- Japanese alley aesthetic
- Responsive design

## Screenshots

The application features a cinematic Japanese alley aesthetic with:
- Dark warm theme
- Glowing lantern effects
- Glassmorphism panels
- Premium moody atmosphere

## Future Improvements

- Add user authentication
- Implement rate limiting
- Add conversation history view
- Support for multiple AI models
- Add streaming responses
- Mobile app version

## License

MIT