# Vibecoded - AI Tools Used

This project was built using AI-assisted development tools.

## AI Tools Used

### Claude Code (Anthropic)
- **Purpose:** Primary development assistant throughout the project
- **Role:** Full-stack architecture, code generation, debugging, deployment configuration, UI design, git workflow

### Supporting Configuration
- Model: claude-sonnet-4-6 (Claude Code CLI)
- Stack chosen: Node.js + Express backend, React + Vite frontend
- Pattern: MVC architecture for backend, component-based for frontend

## What AI Helped With

1. **Project Setup**
   - Initialized Vite + React frontend structure
   - Set up Express.js backend with MVC folder layout

2. **Backend Development**
   - MongoDB Atlas connection via Mongoose
   - Groq API integration (llama-3.1-8b-instant model)
   - Chat schema design (question + answer storage)
   - Express routes, controllers, CORS security

3. **Frontend Development**
   - React UI with glassmorphism design
   - Typewriter animation for AI responses
   - Rotating placeholder effect on input
   - Pixel art background integration

4. **Deployment**
   - `vercel.json` configuration for backend serverless deployment
   - `vercel.json` for frontend SPA routing on Vercel
   - CORS restricted to FRONTEND_URL environment variable
   - `module.exports = app` for Vercel Node.js runtime compatibility

5. **Git Workflow**
   - Incremental commits per feature phase
   - Descriptive commit messages

## Build Commands

### Frontend
```bash
cd frontend
npm run dev    # Development server
npm run build  # Production build
```

### Backend
```bash
cd backend
npm run dev    # Development server
npm start      # Production server
```

## Notes

All features are fully functional with no placeholder implementations. Security practices applied: CORS origin restriction, input validation, environment variables for secrets.
