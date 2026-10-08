<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Answers turns an existing AI Agent into a RAG answer engine: a visitor asks a question and gets a written, citation-backed answer built only from indexed site content.

---

AI Answers is a retrieval-augmented generation (RAG) answer engine for Drupal 11.2+. A Question block posts a visitor's question to a POST API endpoint (`/ai-answers/question`), which runs the linked `ai_agent` through its own execution loop; retrieval happens as a real `ai_search:rag_search` tool call against a fixed, pre-configured Search API index. The generated answer is grounded strictly in the retrieved sources (a built-in citation contract instructs the model to use nothing else), carries inline `[n]` markers, and is rendered together with each cited source shown as a Drupal entity in a view mode you choose. An Answer block renders the response, its references, and optional thumbs feedback; both blocks are cacheable static shells and the answer arrives over the API via vanilla JavaScript (streamed as Server-Sent Events, or one JSON response). The module owns a single configuration object (`ai_answers.agents`) holding per-agent settings — enable flag, provider/model override, reference view mode, extra prompt guidance, no-answer message, feedback toggle, conversation TTL, and a history-turns cap. Conversations (question/answer turns) are held in an expirable key-value store; optional integrations persist answers and feedback to `ai_log` (via ai_logging) and correlate traces via Langfuse. It depends on `ai`, `ai_agents`, and `ai_search`.

---

- Add a "ask a question, get a cited answer" experience to a content-rich site.
- Give a knowledge base or support portal a plain-language Q&A entry point.
- Answer product or service documentation questions from indexed pages.
- Ground every answer in your own content and suppress model general knowledge.
- Show each answer's sources as rendered Drupal entities with links back.
- Place a "Search Anywhere, Answer Here" search box in the header feeding one shared answer region.
- Point several Question blocks on different pages at a single Answer block.
- Hand a question across pages via a URL fragment when the Answer block is elsewhere.
- Stream the answer token-by-token as Server-Sent Events for a live feel.
- Return one complete JSON answer instead of streaming, for simpler clients.
- Offer follow-up questions that thread prior turns as conversation context.
- Cap how many prior turns are sent to the model to bound follow-up token cost.
- Collect thumbs up/down feedback on answers from site visitors.
- Persist answers and feedback as queryable `ai_log` entities (with ai_logging).
- Correlate each answer with a Langfuse trace for observability (with Langfuse).
- Override the provider/model per agent, or fall back to the site default chat-with-tools provider.
- Rerank retrieved chunks when a rerank provider is configured, before citing.
- Choose the view mode used to render each cited source entity.
- Set a custom "no usable sources" message per agent.
- Configure conversation retention (TTL) so follow-ups stay available for a set time.
- Restrict who can call the answer endpoints via the `use ai answers` permission.
- Expose answer log/trace correlation ids only to trusted roles via `view ai answers traces`.
- Add suggested-question chips under a Question input to guide visitors.
- Surface AI Answers status directly on the AI Agent edit form.
- Provide an intranet, HR, or policy portal with a direct-answer front end.
- Localize block labels and per-agent settings via config translation.
