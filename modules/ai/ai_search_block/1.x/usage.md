AI Search Block answers visitor questions in natural language, using an LLM that writes from your own Search API-indexed content (RAG) and links back to the source pages.

---

AI Search Block provides a pair of Drupal blocks — an "AI Search" form block for the question and an "AI Search Response" block where the answer streams in word by word. Both point at a Search API index that stores your content (typically as vectors via `ai_search`). On submit, the module retrieves the most relevant indexed items, renders them (as chunks or as rendered entities in a chosen view mode), builds an editable aggregation prompt, and sends it to a chat model through the `drupal/ai` provider abstraction. The streamed HTML answer includes source links. Retrieval is configurable (score threshold, min/max results, optional bi-encoder reranking, retrieval-prefix templates), the prompt supports entity/user/date placeholders and an optional system/user split, and a traditional Drupal View can render classic keyword results beneath the AI answer. Four submodules add textarea UX (`ai_search_block_extras`), a header search box (`ai_search_block_header`), question/answer logging with visitor scoring and analytics (`ai_search_block_log`), and AI tag classification of logged questions (`ai_search_block_log_tag`).

---

- Add a natural-language "ask a question" box to any page via the AI Search form block.
- Place the streamed answer anywhere on the page with the separate AI Search Response block.
- Answer questions purely from your own indexed content instead of general model knowledge.
- Link every answer back to the source entities it used.
- Point the block at any Search API index (vector index from `ai_search` for semantic RAG).
- Tune retrieval with a score threshold and minimum result count before an answer is attempted.
- Show a custom "no sufficient results" message when the index lacks an answer.
- Cap the number of retrieved results fed to the LLM with a max-results setting.
- Improve relevance with optional bi-encoder reranking over a larger candidate set.
- Add a retrieval prefix template for asymmetric embedding models (e5-instruct, GTE-QWEN).
- Choose the chat model per block or fall back to the AI module's default chat provider.
- Edit the aggregation prompt with `[question]`, `[entity]`, user and date placeholders.
- Split the prompt into system and user parts with the `-----! SPLIT !-----` marker for small models.
- Render sources as raw chunks or as fully rendered nodes in a selected view mode.
- Stream the answer live, or return it in a single non-streaming response.
- Animate multi-language placeholder text and rotate loading messages.
- Block questions containing configured words with a custom refusal message.
- Show traditional Drupal View (keyword) results below the AI answer with AJAX paging.
- Support multiple form + response block pairs on one page via matching wrapper IDs.
- Place blocks through the standard Block layout UI or inside Layout Builder.
- Add a themed header search box that redirects into the AI Search page and auto-runs the query.
- Auto-grow the textarea input as the visitor types (extras submodule).
- Log every question, answer, prompt, and sources for review (log submodule).
- Let visitors rate answers and leave feedback, then review admin dashboards and charts.
- Classify logged questions into your own per-block tag vocabulary on cron (log-tag submodule).
- Extend behaviour with `hook_ai_search_block_prompt_alter()` and entity HTML/markdown alters.
