<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: AI Visual Embeddings (advanced_filesystem_ai_embeddings) — agent index

Submodule of **Advanced FileSystem**. Builds a local, pixel-based **127-dim visual embedding**
(PHP-GD) for managed images plus **pHash/dHash** fingerprints and a **quality score**, then offers
similarity search, near-duplicate detection, PCA map and k-means clustering. An **opt-in** AI layer
(via **drupal/ai**) adds a vision description, tags, a text embedding and a safety label.

- **Depends on:** `advanced_filesystem`, core `file`, core `media`. AI layer additionally needs
  `drupal/ai` (`@?ai.provider`, injected optionally). `configure` route
  `advanced_filesystem_ai_embeddings.settings`. Package *Advanced Filesystem*. Version 1.0.27.
- Core requirement `^10 || ^11 || ^12`. License GPL-2.0-or-later.

## What it provides

- **Services** — `advanced_filesystem_ai_embeddings.visual_embedding`
  (`VisualEmbeddingService`, the local GD pipeline: analyse, store, cosine similarity, duplicates,
  by-colour, neighbours, PCA, k-means) and `advanced_filesystem_ai_embeddings.ai_enrichment`
  (`AiEnrichmentService`, opt-in drupal/ai vision + text embeddings). See
  [api/services.md](api/services.md).
- **Config** — one object `advanced_filesystem_ai_embeddings.settings` (13 keys; AI keys default
  **off**). See [config/settings.md](config/settings.md).
- **Admin UI + JSON API** — settings, batch, log, per-file page (view/re-extract/AI-enrich/delete),
  search, duplicates, map, clusters, and a permission-gated `/api/ai-embeddings/*` JSON API. Routes,
  permissions and controllers in [routes/ui-and-api.md](routes/ui-and-api.md).
- **Permissions** — `administer advanced_filesystem_ai_embeddings` (all admin UI) and
  `access advanced_filesystem_ai_embeddings api` (JSON API). Both `restrict access: true`.
- **Plugins/hooks** — Media source `adfs_ai_embeddings` (`Plugin/media/Source/AiEmbeddingsSource`);
  `hook_file_insert` (optional analyse/enrich on upload), `hook_file_delete` (cleanup),
  `hook_cron` (log pruning + neighbour precompute), `hook_entity_operation`,
  `hook_views_data` (exposes `adfs_ai_emb` + `adfs_ai_emb_ai` to Views).
- **Drush** — `adfs:ai-emb:analyze | stats | dedup | neighbors | ai-enrich | low-quality`
  (`Commands/AiEmbeddingsCommands`).
- **Tables** — `adfs_ai_emb` (vector+info+hashes+quality), `adfs_ai_emb_ai` (AI enrichment),
  `adfs_ai_emb_neighbors` (precomputed KNN), `adfs_ai_emb_log` (analysis log).

## Key facts (from source)

- The visual embedding is **fully local** — `VisualEmbeddingService` never calls out; it reads the
  managed file from disk (`file_system->realpath()` + `file_get_contents`) and decodes with GD.
- The AI layer is a **no-op unless** `ai_enabled` is set AND drupal/ai has a provider for the
  vision (`chat_with_image_vision`/`chat`) and `embeddings` operations. All AI I/O goes through the
  provider abstraction (`$provider->chat()`, `$provider->embeddings()`) — this module holds no API
  key and makes no direct HTTP call.
- All admin/API routes require the two `restrict access` permissions above; the re-extract and
  AI-enrich action routes also require a CSRF token.
