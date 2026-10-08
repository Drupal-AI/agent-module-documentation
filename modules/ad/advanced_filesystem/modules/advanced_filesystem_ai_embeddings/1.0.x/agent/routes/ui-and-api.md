<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions, controllers & forms — advanced_filesystem_ai_embeddings

## Permissions (`*.permissions.yml`)

- **`administer advanced_filesystem_ai_embeddings`** (`restrict access: true`) — every admin UI
  route below.
- **`access advanced_filesystem_ai_embeddings api`** (`restrict access: true`) — the JSON API only.

## Admin UI routes (all under `administer advanced_filesystem_ai_embeddings`)

| Route / path | Handler | Purpose |
|---|---|---|
| `…settings` — `/admin/config/media/advanced_filesystem/ai-embeddings` | `AiEmbeddingsSettingsForm` | Settings (see config/settings.md). |
| `…batch` — `…/batch` | `AiEmbeddingsBatchForm` | Bulk-analyse existing images. |
| `…log` — `…/log` | `AiEmbeddingsLogController::overview` | Last 200 analysis-log rows. |
| `…search` — `…/search` | `AiEmbeddingsSearchForm` | Reverse-image (upload) + by-colour search. |
| `…duplicates` — `…/duplicates` | `AiEmbeddingsDuplicatesController::overview` | pHash duplicate groups. |
| `…map` — `…/map` | `EmbeddingMapController::map` | 2D PCA scatter (inline SVG). |
| `…clusters` — `…/clusters` | `EmbeddingClustersController::overview` | k-means cluster galleries. |
| `…file_view` — `/admin/content/files/{file}/ai-embeddings` | `AiEmbeddingsViewController::view` | Per-file page: info, quality, fingerprint, similar, AI section. |
| `…file_reextract` — `…/reextract` | `…ViewController::reextract` | Regenerate embedding. **`_csrf_token: TRUE`**. |
| `…file_ai_enrich` — `…/ai-enrich` | `…ViewController::aiEnrich` | Run AI enrichment. **`_csrf_token: TRUE`**. |
| `…file_delete_confirm` — `…/delete` | `FileDeleteConfirmForm` | Delete the managed file (double-confirm). |

`{file}` is an `entity:file` param constrained to `\d+`.

## JSON API routes (GET, `access advanced_filesystem_ai_embeddings api`)

`AiEmbeddingsApiController`, returns `application/json` for headless front-ends:

- `/api/ai-embeddings/stats` — coverage counts + model metadata.
- `/api/ai-embeddings/{file}` — stored embedding + info + hashes + AI enrichment; `?vector=1` adds
  the raw vectors.
- `/api/ai-embeddings/{file}/similar` — `?k=`, `?mode=visual|semantic|hybrid`, `?alpha=` (hybrid
  blend); dispatches to the matching service method. `k` clamped 1–100.
- `/api/ai-embeddings/clusters` — `?k=` (1–50), `?scan_max=` (1–5000), `?limit=` per cluster.

## Rendering notes (for anyone extending the UI)

The controllers/forms build small inline-styled HTML via `Markup::create`. Every dynamic value that
reaches markup — filenames, file URLs, dominant-colour hex, AI description, AI tags, safety label,
quality flags, pHash/dHash, the SVG map's point labels — is passed through
`htmlspecialchars(…, ENT_QUOTES)` first (or rendered through a core `#type => table`, which the
theme escapes). The JSON API emits everything through `JsonResponse` (JSON-encoded). The
reverse-image search analyses the uploaded file **in memory only** (`analyzeImageData()`); it is
never written as a managed file and no request-supplied URL is fetched server-side.

## Hooks (`.module`)

- `hook_entity_operation` — adds "AI Embeddings" (and, when `ai_enabled`, "AI Enrich") operations to
  `file` rows on `/admin/content/files`, gated by the admin permission.
- `hook_file_insert` / `hook_file_delete` — optional analyse/enrich on upload; cleanup on delete.
- `hook_cron` — log pruning + optional neighbour precompute (see config/settings.md).
