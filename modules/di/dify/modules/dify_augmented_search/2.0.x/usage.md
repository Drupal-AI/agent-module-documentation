<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dify Augmented Search provides a placeable Drupal **block** that detects the current search query and renders a streaming **AI answer from a Dify Workflow** alongside the normal search results, with the Dify token kept server-side.

---

The `AugmentedSearchBlock` plugin (id `dify_augmented_search_block`, category *Dify*) is placed on a search-results page. Its block form takes a **base URL** and **token** (`#type => password`), stored in **Drupal State** keyed by a per-block UUID (`dify_augmented_search.block_{uuid}.base_url` / `.token`), plus a markdown theme, an optional **AI-search toggle** (label, target form selectors, default state), the **URL search parameters** to watch (default `search`, `keys`, `query`, `q`, `keyword`), the **Dify input variable** name (default `query`), and colors. `build()` shows a "please configure" message until credentials exist, then themes `dify_augmented_search_block` and attaches the `async_search` (or `async_search_light`) library plus `drupalSettings.difyAugmentedSearch[uuid]` describing the API URL (`/dify-augmented-search/api/chat`), markdown URL, input variable, watched params, and toggle config (block cached per `url.query_args`). The front-end JS reads the query from the URL and POSTs `{block_uuid, …}` to `ChatProxyController::chat`, which validates the body, looks up the block's base URL/token from State by UUID, strips `block_uuid`, and streams the Dify **Workflow** run (`/v1/workflows/run`, stateless single-turn) via the base module's `DifyChatProxyService` — so the token never reaches the browser. Markdown is rendered through the shared `/dify-augmented-search/markdown/render` route. Install with `composer require league/commonmark:^2.8` and `drush en dify_augmented_search`.

---

- Show an AI-generated answer at the top of your search-results page, next to the normal result list.
- Answer visitor queries from a Dify Workflow (e.g. a RAG pipeline over your indexed content).
- Use the stateless Workflow API (`/workflows/run`) for single-turn query→answer, not a chat session.
- Stream the AI answer token-by-token via Server-Sent Events for a responsive feel.
- Render the AI answer as markdown with a light or dark theme.
- Keep the Dify token server-side — the browser only calls the Drupal proxy route.
- Auto-detect the search query from configurable URL parameters (`q`, `keys`, `search`, …).
- Map the query into a named Dify Workflow input variable (default `query`).
- Add an "AI Search" on/off toggle next to one or more search forms (by CSS selector).
- Set whether the AI toggle is on or off by default.
- Theme the answer panel with configurable primary/background/response/text colors.
- Run several augmented-search blocks (e.g. different Workflows per section), each with its own UUID credentials.
- Point the block at Dify Cloud or a self-hosted instance via the base URL.
- Cache the block per query-args context so the right query drives the AI answer.
- Deploy credentials in CI via `drush state:set dify_augmented_search.block_{uuid}.base_url` / `.token`.
- Enhance an existing Search API / core search results page without replacing the search itself.
