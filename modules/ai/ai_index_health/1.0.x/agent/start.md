<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Index Health (ai_index_health) — agent index

**Health/freshness monitoring for AI vector indexes on Search API — detects stale embeddings, coverage gaps, and dimension/model mismatches, and queues targeted re-embedding.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI  •  **Depends on:** `search_api`
- **Dashboard:** `/admin/config/search/ai-index-health` (`administer ai index health`, restricted).
- **Requeue:** `/admin/config/search/ai-index-health/{search_api_index}/reindex` (same permission + `_csrf_token`).
- **Drush:** `ai_index_health.commands` (`AiIndexHealthCommands::report()`), options `--requeue`, `--show-items`.
- **Optional integrations:** `ai`, `ai_search`, `ai_model_registry` (guarded with `moduleExists()`).
- **Security:** Routes permission-gated; the mutating reindex route is CSRF-protected; no anonymous endpoints. No security findings.

See [drush/commands.md](drush/commands.md).
