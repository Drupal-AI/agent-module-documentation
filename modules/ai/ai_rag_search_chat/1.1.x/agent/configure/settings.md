<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI RAG Search Chat

**Configuration > AI > AI RAG Search Chat** (`/admin/config/ai/ai-rag-search-chat`, `administer ai rag search chat`). Config object `ai_rag_search_chat.settings`:

- **rag:** `search_indices` (Search API index ids using the `search_api_ai_search` backend), `top_k` (5), `target_sources` (5), `min_score` (0.3), `context_token_budget` (4000 — highest-scoring chunks are packed up to this token budget), `filter_by_language` (true), `supplementary_search` (true), `supplementary_stop_words`.
- **llm:** `provider_id`, `model_id`, `fast_model_id`, `title_provider_id`, `title_model_id`. No API keys here — provider auth is delegated to `drupal/ai` + Key. Provider/model are picked from the AI module's registered providers (hard-coded model-id fallbacks exist if unset).
- **history:** `max_messages` (10), `retention_days` (30), `anonymous_retention_days` (2). `hook_cron` prunes accordingly.
- **prompt:** `system_instructions`, `empty_response_message`, `term_map` (`term|expansion` per line, expanded whole-word/case-insensitive into the query before retrieval + the model).
- **search / chat / ui:** page titles, `source_display_mode` (teaser), `sources_per_page` (10), `chat.max_message_length` (4000), `ui.ai_disclosure` (shown under the UI), `include_tailwind_cdn`, `typewriter_enabled`.
- **rate_limit:** `enabled` (true), `message_limit_authenticated` (30), `message_limit_anonymous` (10), `message_window` (3600), `session_limit_*` (30/10), `session_window` (3600).
- **debug:** `enabled` (false) — verbose INFO/DEBUG logging.

## Setup
1. Configure a Search API index (AI/vector backend) over the content you want searchable, and select it under `search_indices`.
2. Set the LLM `provider_id`/`model_id` and a lighter `title_*` model (configure credentials in `drupal/ai` + Key).
3. Grant `access ai rag search chat` to the roles that may use search/chat. Keep `administer ai rag search chat` to trusted admins only.
4. Leave `rate_limit.enabled` ON — it throttles the LLM-calling endpoints, which matters most if `access ai rag search chat` is granted to anonymous.

## Notes
- Retrieved entities are access-filtered (`view`) before their content reaches the model or the client, and source rendering re-checks `view` access, so the retrieval/render path respects entity access.
- `update_10004` seeds `chat.max_message_length` and `ui.ai_disclosure` into active config on upgrade without overwriting values a site already set (an explicit empty `ui.ai_disclosure` opts the disclosure out).
