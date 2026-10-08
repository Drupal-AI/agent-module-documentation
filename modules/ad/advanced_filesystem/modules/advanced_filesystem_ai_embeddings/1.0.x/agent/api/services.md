<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, Drush, Media source — advanced_filesystem_ai_embeddings

## VisualEmbeddingService (`advanced_filesystem_ai_embeddings.visual_embedding`)

`src/Service/VisualEmbeddingService.php` — the local, self-contained pipeline. No external calls.

- **Model** `local_visual_v2`, **127 dims** (`MODEL`/`DIMENSIONS`).
- `analyzeFile(FileInterface, $overwrite = TRUE)` → reads the managed file from disk
  (`fileSystem->realpath()` + `@file_get_contents`), decodes with GD, calls `analyzeImageData()`,
  stores, and logs the outcome (`ok|skipped|error`). Guards on GD availability, MIME `image/*`
  (SVG excluded), `max_image_size_mb`, `min_width`.
- `analyzeImageData(string $data): ?array` — the feature extractor. Builds the vector from four
  L2-normalised blocks: **structure** (8x8 luminance grid, flip-folded, 64d), **colour** (12+4+4 HSV
  histograms), **regional colour** (3x3 mean HSV, flip-folded, 27d) and **texture** (4x4 edge grid,
  16d); then a DCT **pHash** (`perceptualHash`) and a **dHash** (`differenceHash`), a heuristic
  `qualityScore()` with flags, and an `info` array (dimensions, brightness/saturation/colorfulness,
  dominant colours, hue histogram).
- Similarity: `cosineSimilarity()`, `findSimilar(fid)` (uses precomputed neighbours when present,
  else scans `adfs_ai_emb`), `findSimilarToVector()` (reverse-image search), `findByColor()`,
  `findDuplicates(threshold)` (pHash Hamming grouping), `findLowQuality()`.
- Clustering/visualisation: `kmeans(k)` (deterministic k-means++ seeded `mt_srand(20240607)`),
  `projectPca2d()` (power iteration + deflation).
- Neighbours: `precomputeNeighbors(topK)` truncates+rebuilds `adfs_ai_emb_neighbors`;
  `loadNeighbors(fid)`.
- Storage helpers: `store()`, `loadEmbedding()`, `loadAllEmbeddings($max, $model)`,
  `deleteEmbedding()` (also clears the AI + neighbour rows), `countEmbeddings()`,
  `countImageFiles()`, `log()`. All DB access uses the parameterised query builder.

## AiEnrichmentService (`advanced_filesystem_ai_embeddings.ai_enrichment`)

`src/Service/AiEnrichmentService.php` — **opt-in**; the `drupal/ai` provider manager is injected
optionally (`@?ai.provider`). Every method is a no-op unless `ai_enabled` is set AND a provider is
configured (`readinessProblem()` / `isEnabled()` / `hasVisionProvider()` / `hasEmbeddingsProvider()`).

- `enrichFile(FileInterface, $overwrite)` → reads the local file, downsizes it to ≤768px
  (`prepareImage()` via GD), calls `describeImage()`, embeds the returned description with
  `embedText()`, and upserts into `adfs_ai_emb_ai`.
- `describeImage()` picks the `chat_with_image_vision` op (falls back to `chat`), attaches the image
  bytes to a `ChatMessage` (`setImageFromBinary`) and calls **`$provider->chat(new ChatInput(...),
  $model, ['adfs_ai_embeddings'])`**. `embedText()` calls **`$provider->embeddings(new
  EmbeddingsInput($text), $model, ...)`**. All transport, auth and API keys are handled by
  `drupal/ai` — this module sets no HTTP/TLS options and stores no key.
- `parseVisionJson()` defensively extracts `{description, tags[], nsfw, nsfw_score}` from the model
  reply. Similarity: `findSemanticSimilar()`, `findHybridSimilar($alpha)` (blends visual + semantic).

## Media source plugin

`Plugin/media/Source/AiEmbeddingsSource` (id **`adfs_ai_embeddings`**, extends core media `File`).
Exposes read-only metadata attributes — quality score, quality flags, embedding model, pHash, AI
description, safety label, safety score — mapped from `adfs_ai_emb` / `adfs_ai_emb_ai` for building
media types and field displays.

## Drush (`Commands/AiEmbeddingsCommands`)

| Command | Purpose |
|---|---|
| `adfs:ai-emb:analyze` (`--mime`, `--limit`, `--force`) | Bulk-generate visual embeddings. |
| `adfs:ai-emb:stats` | Show embedding coverage vs. image count. |
| `adfs:ai-emb:dedup` (`--threshold`) | List near-duplicate groups. |
| `adfs:ai-emb:neighbors` (`--topk`) | Rebuild the precomputed neighbour cache. |
| `adfs:ai-emb:ai-enrich` (`--fid`, `--limit`, `--force`) | Run AI enrichment (needs `ai_enabled`). |
| `adfs:ai-emb:low-quality` (`--max-score`) | List low-quality images. |

## Views & batch

`hook_views_data` (`.views.inc`) exposes `adfs_ai_emb` (fid relationship to `file_managed`, model,
quality, quality_flags, phash, dhash, updated) and `adfs_ai_emb_ai` (description, nsfw, nsfw_score).
`Batch/AiEmbeddingsBatch::process()` powers the "Analyze Existing Images" batch form.
