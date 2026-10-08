<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI RAG Search Chat

**Configuration > AI > AI RAG Search Chat** (`/admin/config/ai/ai-rag-search-chat`, `administer ai rag search chat`). Config object `ai_rag_search_chat.settings`:

- **rag:** `search_indices` (Search API index ids), `top_k` (5), `target_sources` (5), `min_score` (0.3), `context_token_budget` (4000), `filter_by_language` (true), `supplementary_search` (true), `supplementary_stop_words`.
- **llm:** `provider_id`, `model_id`, `fast_model_id`, `title_provider_id`, `title_model_id`. No API keys here — provider auth is delegated to `drupal/ai` + Key. (Hard-coded fallbacks exist if unset.)
- **history:** `max_messages` (10), `retention_days` (30), `anonymous_retention_days` (2). Cron prunes accordingly.
- **prompt:** `system_instructions`, `empty_response_message`, `term_map`.
- **search / chat / ui:** page titles, `source_display_mode` (teaser), `sources_per_page` (10), `include_tailwind_cdn`, `typewriter_enabled`.
- **rate_limit:** `enabled` (true), `message_limit_authenticated` (30), `message_limit_anonymous` (10), `message_window` (3600), `session_limit_*` (30/10), `session_window` (3600).

## Setup
1. Configure a Search API index (with the AI/vector backend) over the content you want searchable, and list its id in `search_indices`.
2. Set the LLM `provider_id`/`model_id` (configure credentials in `drupal/ai` + Key).
3. Grant `access ai rag search chat` to the roles that may use search/chat. Keep `administer ai rag search chat` to trusted admins only.
4. Leave `rate_limit.enabled` ON — turning it off removes throttling on the LLM-calling endpoints.
