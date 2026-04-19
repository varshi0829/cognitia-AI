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

  useEffect(() => {
    const interval = setInterval(() => {
      setPlaceholderIndex((prev) => (prev + 1) % placeholders.length)
    }, 2500)
    return () => clearInterval(interval)
  }, [])

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
      setError(err.response?.data?.error || err.message || 'Failed to get response')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="app">
      <div className="background"></div>
      <div className="main-wrapper">
        <div className="title-section">
          <h1 className="title">Cognitia AI</h1>
          <p className="subtitle">Ask the AI Anything</p>
        </div>

        <form className="input-section" onSubmit={handleSubmit}>
          <div className="input-bar">
            <input
              ref={inputRef}
              type="text"
              className="main-input"
              placeholder={placeholders[placeholderIndex]}
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
              disabled={loading}
            />
            <button type="submit" className="ask-btn" disabled={loading || !question.trim()}>
              {loading ? 'Thinking...' : 'Ask'}
            </button>
          </div>
        </form>

        {error && <div className="error">{error}</div>}

        {answer && (
          <div className="response-card">
            <div className="card-header">
              <span className="model-label">groq</span>
            </div>
            <div className="response-content">
              <p className="answer-text" ref={answerRef}></p>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}

export default App