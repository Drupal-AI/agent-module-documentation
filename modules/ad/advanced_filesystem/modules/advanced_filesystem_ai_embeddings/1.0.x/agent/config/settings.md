<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & install — advanced_filesystem_ai_embeddings

## Install & enable

```bash
composer require drupal/advanced_filesystem      # ships this submodule
drush en advanced_filesystem_ai_embeddings -y    # pulls in advanced_filesystem, file, media
drush cr
```

Requires **PHP GD** for image decoding. The optional AI layer additionally needs
`composer require drupal/ai` and a configured provider at `/admin/config/ai/providers`.

`hook_schema()` (`.install`) creates four tables: `adfs_ai_emb`, `adfs_ai_emb_ai`,
`adfs_ai_emb_neighbors`, `adfs_ai_emb_log`. Update hook `_update_9001` adds the pHash/dHash/quality
columns and the AI + neighbours tables to older installs.

## Config object

Single config object **`advanced_filesystem_ai_embeddings.settings`** (schema in
`config/schema/…schema.yml`, defaults in `config/install/…settings.yml`). Edited at
**`/admin/config/media/advanced_filesystem/ai-embeddings`** (`AiEmbeddingsSettingsForm`,
route `advanced_filesystem_ai_embeddings.settings`, permission
`administer advanced_filesystem_ai_embeddings`).

| Key | Default | Meaning |
|---|---|---|
| `enabled` | `true` | Master switch for local visual-embedding generation (`VisualEmbeddingService::isEnabled()`). |
| `analyze_on_upload` | `false` | Analyse each new image in `hook_file_insert` (non-overwriting). |
| `max_image_size_mb` | `25` | Skip images larger than this (`appliesToFile()`); `0` = no cap. |
| `min_width` | `0` | Skip images narrower than this many px. |
| `similar_default` | `12` | Default result count for "similar" listings/API. |
| `similar_scan_max` | `1000` | Max embeddings scanned per similarity/search/cluster pass. |
| `log_retention_days` | `90` | Cron prunes `adfs_ai_emb_log` rows older than this; `0` = keep. |
| `duplicate_threshold` | `6` | Max pHash Hamming distance treated as a near-duplicate. |
| `quality_threshold` | `0.4` | Score at/below which images are "low quality". |
| `precompute_neighbors` | `false` | Rebuild the top-K neighbour cache during cron. |
| `neighbor_topk` | `24` | Neighbours stored per image when precomputing. |
| `ai_enabled` | `false` | **Opt-in** master switch for the drupal/ai enrichment layer. |
| `ai_nsfw_enabled` | `false` | Ask the vision model for a safety label + confidence. |
| `ai_enrich_on_upload` | `false` | Also run AI enrichment in `hook_file_insert` (may incur API cost). |

All keys are booleans, integers or a float — **no secrets are stored here**. The AI provider,
model and API credentials all live in and are managed by the `drupal/ai` module, not here.

## Cron behaviour (`hook_cron`)

1. Deletes `adfs_ai_emb_log` rows older than `log_retention_days`.
2. If `precompute_neighbors`, calls `VisualEmbeddingService::precomputeNeighbors(neighbor_topk,
   max(similar_scan_max, 2000))`, truncating and rebuilding `adfs_ai_emb_neighbors`.

## Upload-time behaviour (`hook_file_insert`)

Only fires when `enabled` && `analyze_on_upload`. Generates the visual embedding (non-overwriting);
if `ai_enabled` && `ai_enrich_on_upload` and the AI service reports ready, also runs AI enrichment
inside a try/catch (failures are logged, never fatal).
