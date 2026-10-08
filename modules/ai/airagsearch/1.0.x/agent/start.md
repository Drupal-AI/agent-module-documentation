<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI RAG Search (airagsearch) — agent index

Retrieval-augmented search: runs a query against a Search API index, sends the top result
bodies to OpenAI's Chat Completions API as context, and returns an AI answer grounded in that
content plus the normal result list. Also does multi-document summaries and search analytics.

- **Machine name:** `airagsearch` · **Version dir:** 1.0.x (installed 1.0.0-beta1)
- **Depends on:** `search_api` (Search API). Requires Drupal 10/11, PHP 8.1+.
- **External service:** OpenAI Chat Completions (`https://api.openai.com/v1/chat/completions`) via Drupal's `http_client`.
- **Config object:** `airagsearch.settings` (schema in `config/schema/airagsearch.schema.yml`).
- **No entities / no plugin types.** Provides one Block plugin and one DB table (`airagsearch_analytics`).

## Routes (airagsearch.routing.yml)
- `/airagsearch` — `AISearchForm` search page. Perm `access content`.
- `/airagsearch/query` (POST) — `AISearchController::query` AJAX search + AI answer. Perm `access content`, `_csrf_token: TRUE`.
- `/airagsearch/summary` (GET) — `AISearchController::summary` multi-doc summary. Perm `access content`.
- `/admin/config/search/airagsearch` — `AISearchSettingsForm`. Perm `administer ai search settings`.
- `/admin/config/search/airagsearch/test` — `TestConnectionForm`. Perm `administer ai search settings`.
- `/admin/config/search/airagsearch/api` — API docs page. Perm `administer ai search settings`.
- `/admin/reports/airagsearch-analytics` — `AnalyticsAdminController::analytics`. Perm `administer ai search settings`.
- `/api/airagsearch/status|results|summary` (GET) — `AISearchApiController`. Perm `access ai search api` (status/results/summary; results & summary via `::access`).

## Permissions (airagsearch.permissions.yml)
- `administer ai search settings` — configure API key, index, model, analytics.
- `access ai search api` — call the JSON REST endpoints.

## Services (airagsearch.services.yml)
- `airagsearch.openai_client` → `Service\OpenAIClient` — `askChatGPT()`, `askChatGPTSummary()`, `testConnection()`.
- `airagsearch.analytics_logger` → `Service\AnalyticsLogger` — records/prunes query stats in `airagsearch_analytics`.
- `airagsearch.markdown_processor` → `Service\MarkdownProcessor` — `convertToHtml()` minimal markdown→HTML.
- `logger.channel.airagsearch` — logger channel `airagsearch`.

## Plugins / hooks
- Block `airagsearch_block` (`Plugin\Block\AISearchBlock`) — renders `AISearchForm`.
- `hook_theme` (airagsearch.module): `airagsearch_form`, `airagsearch_api_documentation`, `airagsearch_analytics`.
- `hook_help`, `hook_schema` (`airagsearch_analytics` table), `airagsearch_update_11001`.

## Solution docs
- [config/settings.md](config/settings.md) — install, `airagsearch.settings` keys, schema, admin routes.
- [api/endpoints.md](api/endpoints.md) — REST JSON endpoints, params, access.
- [services/openai-client.md](services/openai-client.md) — RAG flow, OpenAI call, markdown, analytics.
