<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search Block Log (ai_search_block_log) — agent index

Submodule of `ai_search_block`. Logs each AI search interaction as an `ai_search_block_log` content
entity, with visitor scoring/feedback and admin analytics dashboards.

## Dependencies
- `ai_search_block` (parent). Core `^10.2 || ^11 || ^12`.

## Provides
- Content entity `ai_search_block_log` (`src/Entity/AiSearchBlockLog.php`): fields `uid`, `block_id`,
  `created`, `expiry`, `question`, `prompt_used`, `response_given`, `detailed_output`, `score`,
  `feedback`. `admin_permission = administer ai_search_block_log`. Standard entity routes
  (collection at `/admin/content/ai-search-block-log`, canonical/edit/delete).
- Permission `administer ai_search_block_log` (`restrict access: true`).
- Controller `AiSearchBlockLogController` (`src/Controller/`): `score()` route
  `/ai-search-block-log/score` (`_permission: 'access content'`) + several `graphs*()` dashboard
  pages (all `_permission: administer ai_search_block_log`).
- Procedural API (`ai_search_block_log.module`): `ai_search_block_log_start()`,
  `ai_search_block_log_add_response()`, `ai_search_block_log_update()` — called by the parent
  controller/helper. Backed by service `ai_search_block_log.helper` (`AiSearchBlockLogHelper`).
- Config form `AISearchBlockLogSettingsForm` (route `entity.ai_search_block_log.settings`) — retention
  period + AI-analysis prompt. Config `ai_search_block_log.settings` (`expiry`, `ai_analysis_prompt`, …).
- `hook_cron()` prunes rows older than the retention window. List builder + Views data.
- Theme hooks / templates for the graph pages; library `ai_search_block_log/graphs` (Chart.js UI).

## Solution docs
- Entity, storage & API: [agent/entity/log-entity.md](entity/log-entity.md)
- Routes, scoring endpoint & dashboards: [agent/api/routes.md](api/routes.md)
