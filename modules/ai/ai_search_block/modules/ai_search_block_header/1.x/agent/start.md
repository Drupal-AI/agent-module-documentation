<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search Block Header (ai_search_block_header) — agent index

Submodule of `ai_search_block`. A core-styled header search box that redirects to the AI Search page
and auto-runs the query there. Does not call the LLM itself.

## Dependencies
- `ai_search_block` (parent). Core `^10 || ^11 || ^12`.

## Provides
- Block plugin `ai_search_block_header_block` (`src/Plugin/Block/AiSearchHeaderBlock`). Single
  setting `destination_path` (default `/basic-page/fancy-search`). `build()` renders the header form
  wrapped in core `search-block-form` markup and attaches the `ai_search_block_header/autorun` library.
- Form `AiSearchHeaderForm` (`ai_search_block_header_form`): a `search` input `q` (maxlength 128) +
  submit. `submitForm()` redirects to `Url::fromUserInput('/' . destination)` with query
  `ai_search_block_q=<term>`.
- `js/autorun.js`: on the destination page reads `ai_search_block_q` from the URL, sets it as the AI
  Search input's `.value` (assignment, not innerHTML), and triggers submit; also a header-capture
  behavior. No routes, permissions, services, or config objects.

## Flow
Header block (any page) → submit → redirect to `destination_path?ai_search_block_q=<term>` →
autorun.js populates + submits the parent AI Search form → answer streams.
