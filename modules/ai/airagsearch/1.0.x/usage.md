<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI RAG Search adds an OpenAI-powered, retrieval-augmented answer layer on top of a Search API index.

---

AI RAG Search (airagsearch) connects Drupal's Search API to OpenAI's Chat Completions API to turn keyword search into question answering. It runs the user's query against a configured Search API index, sends the top result bodies to ChatGPT as context, and renders an AI answer — grounded in the site's own indexed content — next to the normal result list. It also offers a multi-document summary view (up to 20 results), a search analytics dashboard with automatic pruning, a placeable search block, and JSON API endpoints. Administrators configure the OpenAI API key, the index, the model, temperature, token limits, and how much context is sent to the AI. It depends on Search API and supports Drupal 10 and 11 (PHP 8.1+).

---

- Add an AI-written answer above the normal keyword search results on a documentation site.
- Turn a Search API index into a question-answering endpoint at `/airagsearch`.
- Generate a comprehensive multi-document summary of a topic at `/airagsearch/summary`.
- Ground AI answers strictly in indexed site content to reduce hallucination.
- Place an AI search form in any region using the `airagsearch_block` block.
- Choose an OpenAI model (GPT-4o, GPT-4o-mini, GPT-4 Turbo, GPT-3.5) per cost/quality tradeoff.
- Tune answer creativity and length via temperature and max-tokens settings.
- Control OpenAI cost by capping context result count and per-result content length.
- Serve search over a database, Solr, or Elasticsearch Search API backend.
- Monitor the most popular search queries via the analytics dashboard.
- Identify content gaps by reviewing zero-result queries in analytics.
- Cap analytics storage growth with a configurable max-records limit and auto-pruning.
- Test OpenAI connectivity from the admin UI before going live.
- Expose a JSON search endpoint (`/api/airagsearch/results`) for a decoupled front end.
- Expose a JSON AI-summary endpoint (`/api/airagsearch/summary`) for programmatic use.
- Expose a health/status endpoint (`/api/airagsearch/status`) to check configuration state.
- Provide a knowledge-base assistant for an intranet or support portal.
- Answer visitor questions on a government or institutional content portal.
- Paginate keyword results while keeping the AI answer on the first page only.
- Convert AI markdown responses to safe HTML for browser rendering.
- Localize the AI-response and results headings via configuration.
- Restrict programmatic API access to a dedicated `access ai search api` permission.
