<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks & configuration

Two block plugins in `src/Plugin/Block/`. Configuration lives in each block instance's `settings`
(standard Block config entity, or a Layout Builder component); the module ships no config object of
its own. Install: `drush en ai_search_block`, then place both blocks in a region/layout.

## AI Search form block — `ai_search_block` (`SearchFormBlock`)
The question input. `defaultConfiguration()` + `blockForm()` expose (grouped in fieldsets):

- Form: `input_field` (textfield|textarea), `textarea_rows`, `submit_on_enter`, `clear_after_search`,
  `scroll_after_search`, `placeholder` (supports `|`-separated animated placeholders),
  `animate_placeholder`, `submit_text`, `loading_text` (supports `|` rotation), `suffix_text` (HTML,
  admin-authored), `stream` (bool), `response_target_id` (HTML id linking this form to a response block).
- Block/guard: `block_enabled`, `block_words` (newline list), `block_response` (refusal message).
- Source: `database` (required — a `search_api_index` id; options from `getSearchDatabases()`).
- RAG: `score_threshold` (0–1), `min_results`, `no_results_message`, `max_results`, `render_mode`
  (`chunks`|`node`), `rendered_view_mode`, `llm_model` (`provider__model`, empty = AI-module default
  chat), `llm_temp`, `aggregated_llm` (the prompt; default in `blockForm()`), `enable_prefix` +
  `prefix_template` (`{query}` placeholder), reranking (`enable_reranking`, `rerank_candidate_count`,
  `rerank_method` = only `bi_encoder` implemented, `rerank_embedding_model`, `rerank_query_template`),
  `context_threshold`, `access_check` (default `'false'`; the select is commented out in source, so it
  is not user-editable).
- Views: `enable_database_results` + `database_results_view` (`view_id:display_id`).

`blockSubmit()` persists these and records a placement locator: for standard blocks it stores
`block_id` (the config entity id); for Layout Builder it stores `lb_storage_type`/`lb_storage_id`/
`lb_component_uuid`/`lb_view_mode` (from the section storage) so the controller can reload the
canonical settings at request time.

`build()` renders the `ai_search_block_wrapper` theme with the embedded `SearchForm`, attaches the
`ai_search_block/ai_search_block` library, and pushes settings to `drupalSettings.ai_search_block`
(submit_url, db_results_url, placeholder, loading/suffix text, etc.). It also builds a **signed
context payload** via `ai_search_block.context_signer` and stores it in hidden form fields
`search_context` / `search_context_sig` (see api/query-endpoint.md). `#cache max-age` is 0.

## AI Search Response block — `ai_search_block_response` (`SearchResponseBlock`)
Where the answer streams. Only setting: `response_target_id` ("Response wrapper HTML ID", normalized
with `Html::getId()`, default `ai-search-block-response`). `build()` renders the
`ai_search_block_response` theme wrapper. When the paired form block enables database results, it
resolves the paired form settings — `resolvePairedSearchBlockSettings()` matches by wrapper id across
Layout Builder sections (`resolveLayoutBuilderSearchBlockSettings()`) or standard block config
(`resolveBlockEntitySearchBlockSettings()`) — and embeds a `views_block:<view>-<display>` block.

## Frontend (`js/ai_search_block.js`)
`Drupal.behaviors.aiSearchBlock` intercepts submit, POSTs `query`/`stream`/`search_context`/
`search_context_sig` to `submit_url`, and streams chunks (delimiter `|§|`) into the response block's
`.ai-search-block-output`. Also handles clipboard copy, a feedback modal (POSTs to
`/ai-search-block-log/score`), animated placeholders, and AJAX paging of the View results.
