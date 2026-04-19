const Groq = require('groq-sdk');
const Chat = require('../models/Chat');

const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY
});

// @desc    Ask a question to AI
// @route   POST /api/ask
// @access  Public
const askQuestion = async (req, res) => {
  try {
    const { question } = req.body;

    // Input validation
    if (!question || question.trim() === '') {
      return res.status(400).json({ error: 'Question is required' });
    }

    if (question.trim().length < 2) {
      return res.status(400).json({ error: 'Question must be at least 2 characters' });
    }

    // Send to Groq API
    const completion = await groq.chat.completions.create({
      messages: [
        {
          role: 'user',
          content: question
        }
      ],
      model: 'llama-3.1-8b-instant',
      temperature: 0.7,
      max_tokens: 1024
    });

    const answer = completion.choices[0]?.message?.content || 'No response received';

    // Save to MongoDB
    const newChat = await Chat.create({
      question: question.trim(),
      answer
    });

    res.status(201).json({
      answer
    });
  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({ error: 'Failed to get response from AI' });
  }
};

module.exports = { askQuestion };