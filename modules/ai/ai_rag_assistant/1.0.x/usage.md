<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RAG AI Assistant is a self-contained AI chatbot that answers visitor questions from your Drupal node content using Retrieval-Augmented Generation over vector embeddings.

---

RAG AI Assistant indexes your published nodes into vector embeddings (Google Gemini embedding API), stores them in its own database table (`rag_embeddings`), and serves a chat interface — a full page at `/rag-chat` and a floating "RAG AI Chat" block. When a visitor asks a question, the module embeds the query, finds the most similar stored chunks by cosine similarity, builds a context block from them, and asks a generation model (Gemini by default, or OpenAI/Anthropic) to answer grounded in that context, returning the answer plus source links. Nodes are auto-indexed on insert/update and removed on delete; a bulk "Index Content" batch and index/chat-history maintenance tools are provided. It is standalone — it calls the Gemini/OpenAI/Anthropic REST APIs directly and does **not** depend on the `drupal/ai` module; its only Drupal dependency is core `node`.

Operationally: two permissions gate it — `administer rag ai assistant` (settings + indexing at `/admin/config/ai/rag-assistant`) and `use rag ai assistant` (the chat page, the POST API `/api/rag-chat`, and the block). Provider API keys (Gemini/OpenAI/Anthropic) are entered on the settings form and stored in the module's own configuration; the settings page itself recommends overriding them in `settings.php` (or using the Key module) so they are excluded from config exports. Tunable settings include the generation provider/model, embedding model, chunk size/overlap, Top-K, similarity threshold, an "allow general AI knowledge" fallback, the system prompt, and which content types to index. Content and questions are sent to the configured external AI provider over HTTPS (billable egress). Chat history is stored per session in `rag_chat_history` and auto-pruned after 30 days by cron. Requires core `node`; supports Drupal 10.3+, 11, and 12.

---

- Add an AI chatbot that answers from your own site content.
- Expose a full-page chat UI at `/rag-chat`.
- Place a floating "RAG AI Chat" block in any region.
- Ground answers in retrieved node passages (RAG), with source links.
- Auto-index published nodes on create/update; remove on delete.
- Bulk-index all existing content with a batch operation.
- Restrict indexing to selected content types (or index all).
- Choose the generation provider: Gemini, OpenAI, or Anthropic.
- Tune chunk size, overlap, Top-K, and similarity threshold.
- Customize the system prompt to shape tone and behavior.
- Optionally allow general LLM knowledge when no content matches.
- Build a self-service support/knowledge-base assistant.
- Gate the chat with `use rag ai assistant`.
- Gate settings and indexing with `administer rag ai assistant`.
- Store API keys in config, with settings.php override recommended.
- Store embeddings in the `rag_embeddings` database table.
- Keep per-session chat history in `rag_chat_history`.
- Auto-prune chat history older than 30 days via cron.
- Clear the index or chat history from the admin UI.
- Send content and queries to an external AI provider over HTTPS.
- Run without the `drupal/ai` module (direct provider REST calls).
