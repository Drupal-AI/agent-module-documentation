<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Watchdog Analyst (ai_watchdog_analyst) — agent index

Adds a "🤖 Analyze" action to core's **Watchdog / dblog** log viewer that sends a selected log
entry to a chat model (via the **AI** module's provider plugin system) and renders the returned
markdown solution in the admin UI. Package `Custom`. Depends on core **`dblog`** and **`ai`**
(^1.0). Core requirement `^10 || ^11`. Uses **league/commonmark** to render responses. License
GPL-2.0-or-later. Version 1.0.2.

## What it provides

- **Service** `ai_watchdog_analyst.analyzer` → `Service\LogAnalyzerService` — builds the prompt,
  calls the provider, converts markdown → HTML, caches for 24h.
- **Controller** `Controller\AiWatchdogAnalystController` — two route handlers.
- **Form** `Form\SettingsForm` — provider/model/system-prompt config.
- **3 routes** (all admin, permission-gated) and a menu link under *Config → AI*.
- **Hooks** in `.module`: injects the Analyze buttons into the dblog views table and event page,
  and renders a completed analysis via tempstore.
- **2 theme hooks / twig templates**, a modal CSS/JS library `ai_watchdog_analyst/modal`.
- **Config object** `ai_watchdog_analyst.settings` (schema provided). No permissions of its own,
  no plugins, no Drush, no entities.

## Routes (`ai_watchdog_analyst.routing.yml`)

- `ai_watchdog_analyst.suggest_solution` — `/admin/reports/dblog/ai-solution/{wid}` →
  `::suggestSolution`; perm **`access site reports`**; opened in an AJAX modal.
- `ai_watchdog_analyst.analyze_detail` — `/admin/reports/dblog/event/{wid}/analyze` →
  `::analyzeDetail`; perm **`access site reports`**; stores result in tempstore, redirects to
  `dblog.event`.
- `ai_watchdog_analyst.settings` — `/admin/config/ai/watchdog-analyst` → `SettingsForm`; perm
  **`administer site configuration`**.

## Docs

- **Settings form, config object + schema, provider/model selection, system prompt** →
  [config/settings.md](config/settings.md)
- **Routes, hooks, the analysis pipeline (LogAnalyzerService), caching, templates** →
  [api/pipeline.md](api/pipeline.md)

## Key facts (from source)

- Buttons appear only for severity ≤ 4 (Emergency…Warning); Notice/Info/Debug get no button
  (`ai_watchdog_analyst_preprocess_views_view_table` and `_page_bottom` in `.module`).
- `LogAnalyzerService::analyzeLogs()` cache key is `ai_watchdog_analyst:md5(type:message)`, TTL 24h.
- Provider id defaults to `azure`, model falls back to the provider's first configured chat model
  (`getDefaultChatModel`); a "respond in <current language>" line is appended to the system prompt.
- Response markdown is converted by `CommonMarkConverter` with `html_input => 'strip'` and
  `allow_unsafe_links => FALSE` in `markdownToHtml()`.
- No outbound HTTP is made by this module directly — all model I/O goes through the `ai` provider.
