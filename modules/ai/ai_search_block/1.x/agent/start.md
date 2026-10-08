<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search Block (ai_search_block) — agent index

RAG search for Drupal: a visitor question is answered by a chat LLM writing from your own
Search API-indexed content, with source links. Version dir `1.x` (installed `1.0.0-rc24`).

## What it is
- Two block plugins (`src/Plugin/Block/`): `ai_search_block` (`SearchFormBlock`, the question
  form) and `ai_search_block_response` (`SearchResponseBlock`, where the streamed answer +
  optional View results appear). Pair them by matching wrapper/target IDs.
- The form posts to a controller that retrieves from a Search API index, renders hits, builds an
  aggregation prompt, and streams the model answer back.

## Dependencies
- Drupal modules: `ai_search` (from `drupal/ai`), `search_api`. Core `^10.2 || ^11 || ^12`.
- Composer libs: `drupal/ai ^1.2`, `drupal/search_api ^1.39`, `league/html-to-markdown ^5.1`,
  `league/commonmark ^2.6`.

## Provides
- Blocks: `ai_search_block`, `ai_search_block_response`.
- Form: `SearchForm` (`ai_search_block_form`), built into the form block.
- Controller `AiSearchBlockController` with routes `ai_search_block.api`
  (`/ai-search-block/query`) and `ai_search_block.db_results` (`/ai-search-block/db-results`),
  both `_permission: 'access content'`.
- Services: `ai_search_block.helper` (`AiSearchBlockHelper`, RAG + LLM), `ai_search_block.context_signer`
  (`SearchContextSigner`, HMAC+AES signed stateless block-settings payload).
- Alter hooks (see `ai_search_block.api.php`): `hook_ai_search_block_prompt_alter`,
  `hook_ai_search_block_entity_html_alter`, `hook_ai_search_block_entity_markdown_alter`.
- Theme hooks: `ai_search_block_wrapper`, `ai_search_block_response`. Library `ai_search_block/ai_search_block`.

## Solution docs
- Blocks & configuration: [agent/config/blocks.md](config/blocks.md)
- Query endpoint, RAG flow & signed context: [agent/api/query-endpoint.md](api/query-endpoint.md)
- Alter hooks: [agent/api/hooks.md](api/hooks.md)

## Submodules (documented separately)
- `ai_search_block_extras` — [../modules/ai_search_block_extras/1.x/agent/start.md](../modules/ai_search_block_extras/1.x/agent/start.md)
- `ai_search_block_header` — [../modules/ai_search_block_header/1.x/agent/start.md](../modules/ai_search_block_header/1.x/agent/start.md)
- `ai_search_block_log` — [../modules/ai_search_block_log/1.x/agent/start.md](../modules/ai_search_block_log/1.x/agent/start.md)
- `ai_search_block_log_tag` — [../modules/ai_search_block_log_tag/1.x/agent/start.md](../modules/ai_search_block_log_tag/1.x/agent/start.md)
