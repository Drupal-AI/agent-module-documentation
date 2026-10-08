OpenAI ChatGPT Explorer adds an admin form for having a back-and-forth conversation with OpenAI's
Chat endpoint using `gpt-*` models. It keeps the message history for the session, so follow-up
questions build on earlier turns, and lets you set a system "profile" that steers the assistant's
behavior.

---

The module provides one form at `/admin/config/openai/chatgpt` (`ChatGptForm`), gated by the
`access openai chatgpt` permission. On each submit it appends the user's text to the running
`messages` array (seeding it with the system profile on the first turn), calls the parent
`openai.api` service's `OpenAIApi::chat()`, stores the assistant reply back into form storage, and
rebuilds so the AJAX callback shows the latest answer. Model options come from `filterModels(['gpt'])`
(default `gpt-3.5-turbo`), with temperature, max-tokens and per-model token validation. It has no
configuration object or Drush command and depends on the parent OpenAI module for the API key and
service. Since the whole conversation is resent each turn, longer chats consume more tokens, and the
system profile is fixed once a conversation starts (reload to change it).

---

- Have a multi-turn chat with ChatGPT from inside Drupal.
- Set a system profile to shape the assistant's tone and role.
- Test how gpt-3.5 vs gpt-4 models answer the same question.
- Prototype a support/assistant persona before building it out.
- Ask follow-up questions that build on prior context.
- Experiment with temperature for more or less creative replies.
- Draft content collaboratively with an AI assistant.
- Validate the OpenAI chat connection and model access.
- Explore prompt-engineering ideas interactively.
- Demonstrate conversational AI to stakeholders.
- Brainstorm ideas with iterative refinement.
- Compare token limits across chat models.
- Get quick answers to Drupal or coding questions.
- Test system-prompt phrasing effects on behavior.
- Draft email or copy in a conversational flow.
- Evaluate response quality for a chosen model.
- Teach editors how conversation context influences answers.
- Generate iterative summaries of pasted text.
- Sanity-check a chatbot prompt design.
- Explore multi-step reasoning within the token budget.
