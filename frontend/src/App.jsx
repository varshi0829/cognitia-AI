import { useState, useEffect, useRef } from 'react'
import axios from 'axios'
import './App.css'

function App() {
  const [question, setQuestion] = useState('')
  const [answer, setAnswer] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [placeholderIndex, setPlaceholderIndex] = useState(0)
  
  const placeholders = [
    'Ask anything...',
    'What is Bitcoin?',
    'Explain Java OOP',
    'How to learn coding?',
    'Tell me about AI'
  ]

  const inputRef = useRef(null)
  const answerRef = useRef(null)

  // Rotating placeholder effect
  useEffect(() => {
    const interval = setInterval(() => {
      setPlaceholderIndex((prev) => (prev + 1) % placeholders.length)
    }, 2500)
    return () => clearInterval(interval)
  }, [])

  // Typewriter effect for answer
  useEffect(() => {
    if (answer && answerRef.current) {
      answerRef.current.innerText = ''
      let index = 0
      const timer = setInterval(() => {
        if (index < answer.length) {
          answerRef.current.innerText += answer[index]
          index++
        } else {
          clearInterval(timer)
        }
      }, 30)
      return () => clearInterval(timer)
    }
  }, [answer])

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (!question.trim()) {
      setError('Please enter a question')
      return
    }

    setLoading(true)
    setError('')
    setAnswer('')

    try {
      const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000'
      const response = await axios.post(`${API_URL}/api/ask`, {
        question: question.trim()
      })
      setAnswer(response.data.answer)
    } catch (err) {
      setError(err.response?.data?.error || 'Failed to get response. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="app">
      <div className="background"></div>
      
      <div className="container">
        <div className="glass-panel">
          <div className="header">
            <h1 className="title">Cognitia AI</h1>
            <p className="subtitle">Ask the AI Anything</p>
          </div>

          <form className="input-section" onSubmit={handleSubmit}>
            <div className="input-wrapper">
              <input
                ref={inputRef}
                type="text"
                className="input"
                placeholder={placeholders[placeholderIndex]}
                value={question}
                onChange={(e) => setQuestion(e.target.value)}
                disabled={loading}
              />
            </div>
            <button type="submit" className="ask-btn" disabled={loading}>
              {loading ? 'Thinking...' : 'Ask'}
            </button>
          </form>

          {error && <p className="error">{error}</p>}

          {answer && (
            <div className="response-card">
              <p ref={answerRef} className="answer-text"></p>
            </div>
          )}

          <footer className="footer">
            <span>Powered by Groq + MongoDB</span>
          </footer>
        </div>
      </div>
    </div>
  )
}

export default App