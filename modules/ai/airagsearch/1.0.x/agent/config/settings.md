<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# airagsearch — configuration & admin

## Install
```
composer require drupal/airagsearch
drush en airagsearch -y
```
Requires `search_api` and at least one configured, populated Search API index (DB backend is
enough). `airagsearch_schema()` (airagsearch.install) creates the `airagsearch_analytics` table;
`AnalyticsLogger::ensureAnalyticsTable()` also self-creates it on first log if missing.

## Config object: `airagsearch.settings`
Set via `Form\AISearchSettingsForm` at `/admin/config/search/airagsearch` (perm
`administer ai search settings`). Schema: `config/schema/airagsearch.schema.yml`. Keys:

| Key | Type | Default (fallback in code) | Purpose |
|---|---|---|---|
| `openai_api_key` | string | — | OpenAI key; validated against `/^sk-[a-zA-Z0-9\-_]+$/`. Blank on save keeps existing key. |
| `search_api_index` | string | — | Search API index machine id to query. |
| `chatgpt_model` | string | `gpt-4o-mini` | Model id (GPT-4o / 4o-mini / 4 Turbo / 4 / 3.5-turbo variants). |
| `result` | integer | 10 | Results per page. |
| `snippet_length` | integer | 300 | Max chars per result snippet. |
| `ai_context_results_count` | integer | 3 | # top results fed to the AI answer. |
| `summary_results_count` | integer | 20 | # results fed to the summary. |
| `ai_context_length` | integer | 1200 | Max body chars per doc sent to OpenAI. |
| `analytics_max_records` | integer | 1000 | Cap on analytics rows; oldest pruned by `last_accessed`. |
| `temperature` | float | 0.7 | OpenAI temperature (0–2, validated). |
| `max_tokens` | integer | 500 | Max answer tokens (50–4000, validated). |
| `summary_max_tokens` | integer | (max_tokens or 800) | Max summary tokens (schema-only; no form field). |
| `ai_response_title` / `search_results_title` / `no_results_message` | label/text | translated defaults | Headings on the search page. |

Note: `info.yml` declares no `configure:` link; the settings form is reached via
`airagsearch.links.menu.yml` / `.links.task.yml`, not the Extend "Configure" button.

## Admin routes
- `/admin/config/search/airagsearch` — settings (`AISearchSettingsForm`).
- `/admin/config/search/airagsearch/test` — `TestConnectionForm` → `OpenAIClient::testConnection()` (20-token ping).
- `/admin/config/search/airagsearch/api` — API documentation page (theme `airagsearch_api_documentation`).
- `/admin/reports/airagsearch-analytics` — `AnalyticsAdminController::analytics`: Chart.js daily chart
  (`AnalyticsLogger::getDailyStats`), top-100 query table, zero-result table.

All four require `administer ai search settings`.

## Analytics
`AnalyticsLogger::logSearch($query, $zero_results)` is called from `AISearchController::query()`
on every executed search: UPDATE-then-INSERT aggregation on the unique `query` column, then prunes
to `analytics_max_records` by `last_accessed`. `getAnalytics()`, `getZeroResultQueries()`,
`getDailyStats($days)` back the dashboard.
