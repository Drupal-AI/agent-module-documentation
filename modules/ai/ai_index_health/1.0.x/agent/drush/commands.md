<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Index Health — Drush

Service `ai_index_health.commands` → `AiIndexHealthCommands::report()`:

```
drush ai_index_health:report [index_id] [--requeue] [--show-items]
```

- `index_id` (optional) — limit to one Search API index; omitted → all indexes.
- `--requeue` — queue the affected (stale / gap) items for re-embedding via the Search API tracker instead of reporting only.
- `--show-items` — list the affected item ids in the output.

Output includes stale-embedding counts, coverage gaps, and dimension/model-mismatch warnings per index. The same targeted-requeue action is available in the UI at `/admin/config/search/ai-index-health/{index}/reindex` (CSRF-protected, `administer ai index health`).
