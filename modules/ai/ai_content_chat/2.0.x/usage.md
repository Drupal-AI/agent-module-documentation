AI Content Chat adds a floating chatbot block that answers visitor questions using only your indexed site content (RAG), via the Drupal AI module.

---

AI Content Chat indexes selected content entities (nodes and any other content entity type, plus text extracted from attached TXT/SRT/CSV/PDF/DOCX files) into a dedicated `ai_content_chat_index` database table. When a user asks a question through the chat widget, the module keyword-scores the index, builds a context block from the top matches, injects it into a strict system prompt, and sends it to the configured AI provider/model for an answer. Content is (re)indexed automatically on entity insert/update/delete and can be fully rebuilt from the settings form. Conversations are never persisted. Administration lives at `/admin/config/ai/content-chat`; the ask endpoint is gated by the `use ai content chat` permission plus a CSRF header token, and the widget is placed as the "AI Content Chat" block.

---

- Add an AI-powered support chatbot that answers only from your own site content.
- Provide RAG-style question answering grounded in indexed nodes and fields.
- Let visitors ask natural-language questions about articles, docs, or product pages.
- Index a knowledge base built from multiple content types at once.
- Include text extracted from attached PDF, DOCX, TXT, CSV, or SRT files in answers.
- Turn subtitle (SRT) files of videos into searchable, answerable content.
- Automatically keep the chatbot index in sync as editors create and edit content.
- Remove content from the chatbot answers automatically when it is unpublished or deleted.
- Place a floating chat widget on specific pages using core block visibility rules.
- Restrict the chatbot to logged-in roles by controlling the "Use AI Content Chat" permission.
- Customize the widget title, welcome message, placeholder, and brand colors per block.
- Choose any chat-capable AI provider and model configured through the Drupal AI module.
- Tune answer behavior with temperature and max-token settings.
- Enforce a strict "answer only from site content" system prompt to reduce hallucination.
- Show a configurable fallback message when no relevant content is found.
- Run a full manual re-index after changing which content types or fields are indexed.
- Batch-index large sites in chunks to avoid timeouts.
- Offer an FAQ-style assistant on documentation or help sections.
- Provide a content-discovery helper that points users to relevant pages.
- Deploy a privacy-friendly chatbot that stores no conversation history.
- Answer employee questions on an intranet from internal published pages.
- Build a product Q&A assistant sourced from product description fields.
- Expose a JSON ask endpoint (`/api/ai-content-chat/ask`) for a custom front-end.
