<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, scoring endpoint & dashboards

Routes in `ai_search_block_log.routing.yml`; controller `AiSearchBlockLogController`.

## Scoring / feedback endpoint
- `ai_search_block.score` → `/ai-search-block-log/score` → `AiSearchBlockLogController::score()`,
  `_permission: 'access content'`. Reads `log_id`, `score`, `feedback` (POST or query), and calls
  `$this->helper->update((int) $logId, ['score' => …, 'feedback' => …])`. Returns a JSON thank-you.
  This is the endpoint the visitor feedback modal in the parent's `js/ai_search_block.js` posts to.

## Config
- `entity.ai_search_block_log.settings` → `/admin/config/ai/ai_search_block_log/config` →
  `AISearchBlockLogSettingsForm`, `_permission: administer ai_search_block_log`. Retention period +
  AI-analysis prompt.
- `ai_search_block_log.settings.menu` → `/admin/config/ai/ai_search_block_log`,
  `_permission: access administration pages` (a menu landing page).

## Dashboards (all `_permission: administer ai_search_block_log`)
Under `/admin/config/ai/ai_search_block_log/graphs*`:
- `graphsOverview()` — key monthly metrics + scoring stats (theme `..._graphs_overview`).
- `graphs()` — full legacy dashboard (per-day/score/block/user charts + AI analysis).
- `graphsAiAnalysis()` — `getAiAnalysisWithFeedback()` asks the default chat model to summarise
  low-scored (`score <= 2`) or feedback-bearing rows; renders the model text.
- `graphsSearchStats()`, `graphsScoringStats()` — search/score charts.

All dashboard queries use the core Database `select()` API with bound parameters (the dynamic
`score_$score` expressions bind values, not concatenate) — no string-SQL injection. Results are day-
cached (`cache.default`, 1h). Chart rendering happens in `js/graphs.js` via `drupalSettings`.

## Entity admin
Standard content-entity routes (collection `/admin/content/ai-search-block-log`, add/edit/delete,
delete-multiple), all gated by `administer ai_search_block_log`.

## Hooks (`Hook/AiSearchBlockLogHooks`)
`hook_cron` → helper prune; `hook_form_alter` attaches the log JS library to the AI search form;
`template_preprocess_ai_search_block_log`; theme hooks for the five graph templates.
