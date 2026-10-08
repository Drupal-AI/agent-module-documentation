<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Index Health monitors the freshness and coverage of AI vector indexes built on Search API and can requeue only the affected items for re-embedding.
---
Vector databases and AI Search provide batch indexing but nothing tells you whether the embeddings you already have still reflect your content. For every Search API index this module answers three operational questions: **stale embeddings** (items changed after they were last embedded), **coverage gaps** (indexable items never tracked, so never embedded), and **dimension/model mismatch** (the model/vector size the index was built with vs. the model configured today, with an optional end-of-life signal from AI Model Registry). It uses real Search API structures only — the `search_api_item` tracker table for per-item state, each datasource's `getItemIds()` for what should be indexable, and each entity's `getChangedTime()` for true content-change time. Optional integrations (`ai`, `ai_search`, `ai_model_registry`) are all guarded with `moduleExists()`, degrading gracefully.

Rather than a full reindex, it can queue only affected items via the Search API tracker. A dashboard lives at `/admin/config/search/ai-index-health` and a per-index requeue action at `.../{search_api_index}/reindex` (CSRF-token protected), both gated by the restricted `administer ai index health` permission. A Drush command (`ai_index_health.commands`, `AiIndexHealthCommands::report()`) reports health per index with `--requeue` and `--show-items` options. No anonymous or public endpoints.
---
- Detect stale embeddings whose source content changed after last embed.
- Find coverage gaps — indexable items never tracked/embedded.
- Detect embedding dimension or model mismatches on an index.
- Surface an end-of-life signal for a retired model via AI Model Registry.
- View a health dashboard for all Search API indexes.
- Queue only the affected items for targeted re-embedding.
- Requeue a specific index from the UI (CSRF-protected).
- Run a CLI health report with the Drush command.
- Requeue affected items from Drush with `--requeue`.
- List affected item ids with `--show-items`.
- Avoid costly full reindexes by re-embedding only what changed.
- Compare an index's built vector size against the provider's current size.
- Degrade to Search-API-level checks when AI modules are absent.
- Confirm embeddings reflect current content before serving RAG.
- Monitor index freshness as an operational health check.
- Diagnose why some content never appears in vector search.
- Catch a model swap that invalidated existing vectors.
- Restrict monitoring/requeue to admins via a restricted permission.
- Schedule the Drush report in cron for ongoing monitoring.
