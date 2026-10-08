<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The base **Dify** module is a service-only integration layer for the Dify LLM-application platform: it provides a Guzzle client for the Dify Knowledge (Dataset) API, a CommonMark markdown renderer, and a server-side Server-Sent-Events (SSE) proxy for Dify chat and workflow calls, all consumed by its four optional submodules.

---

`dify` on its own has no routes, blocks, permissions, config or admin UI — it is the shared foundation the submodules build on. It registers three services in `dify.services.yml`: `dify.markdown_service` (`MarkdownService`, wrapping `League\CommonMark\CommonMarkConverter` configured with `html_input => escape`, `allow_unsafe_links => FALSE`, `max_nesting_level => 10`), `dify.chat_proxy_service` (`DifyChatProxyService`, which streams `POST /v1/chat-messages` and `POST /v1/workflows/run` to Dify over native curl with `CURLOPT_SSL_VERIFYPEER => TRUE`, echoing each SSE chunk as it arrives), and a `logger.channel.dify` channel. The `DifyClient` class (`src/DifyClient.php`) wraps the Dify Dataset REST API (`v1/datasets…`) with methods to list/create/update/delete documents from text or file, manage segments, and manage metadata fields; it is instantiated by the Search API backend with per-server credentials rather than as a container service. `MarkdownController` (`src/Controller/MarkdownController.php`) exposes `MarkdownService::toHtmlStreaming()` as a JSON endpoint, but defines no route itself — each submodule maps its own path to it. `IdentityCardTrait` builds a plain-text "identity card" (compact + verbose field lines, driven by per-field priority) shared by the Search API backend and knowledge pipeline. To do anything visible you enable one or more submodules: `dify_search_api`, `dify_widget_vanilla`, `dify_widget_official`, `dify_augmented_search`. Install with `composer require drupal/dify` then `drush en dify`, and pull in the extra libraries each submodule needs (`search_api` + `league/html-to-markdown` for indexing, `league/commonmark` for the markdown widgets).

---

- Provide a single, tested Guzzle wrapper (`DifyClient`) for the Dify Knowledge/Dataset API to any custom Drupal code.
- Push Drupal content into a Dify knowledge base for retrieval-augmented chatbot answers (via `dify_search_api`).
- Create, update or delete Dify documents from Drupal text with automatic or hierarchical (parent/child) chunking.
- Create Dify documents from uploaded files (PDF, DOCX…) through the Dataset file-upload endpoint.
- Manage Dify document **segments** individually (create/update/delete, batch create) for a contextual-field indexing strategy.
- Ensure and assign Dify **metadata fields** (e.g. a source-URL field) so chatbot answers can cite the originating Drupal page.
- Render streaming LLM markdown responses to safe HTML through a shared, XSS-hardened `MarkdownService`.
- Proxy a Dify chatbot's Chat API through Drupal so the API token never reaches the browser (via `dify_widget_vanilla`).
- Proxy a Dify **Workflow** run through Drupal for single-turn query→answer use cases (via `dify_augmented_search`).
- Embed Dify's own hosted chatbot widget as a placeable Drupal block (via `dify_widget_official`).
- Stream Server-Sent-Events from Dify to the browser in real time using native curl that bypasses Guzzle/middleware buffering.
- Keep all Dify credentials in Drupal State so they are database-only and never exported with configuration to Git.
- Add a logger channel (`dify`) so all Dify integration errors land in one place in the Drupal log.
- Build a consistent plain-text "identity card" header for indexed documents from high-priority entity fields.
- Convert HTML field content to Markdown before indexing (with `league/html-to-markdown`) for cleaner knowledge-base chunks.
- Strip inline base64 image payloads out of text before it is sent to a Dify knowledge base.
- Extract text from file fields via a Dify Workflow (OCR / document parsing) and index the result instead of the file URI.
- Back a fully themeable, accessible floating chat widget (20 CSS color variables, markdown, feedback, suggested questions).
- Serve as the dependency that a site enables once, then layers only the Dify features (indexing, widgets, augmented search) it needs.
