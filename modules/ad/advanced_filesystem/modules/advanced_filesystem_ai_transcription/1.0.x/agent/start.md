<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: AI Transcription (advanced_filesystem_ai_transcription) — agent index

Submodule of **advanced_filesystem** that adds an AI-backed **semantic-extraction pipeline** for
managed files: audio/video transcription, image captioning/analysis/moderation, PDF & Office text
extraction/OCR, taxonomy tagging, and vector embeddings. Package `Advanced Filesystem`. Version
1.0.27. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.

- **Dependencies:** core `file`, `media`, and `advanced_filesystem` (info.yml). The **Drupal AI**
  module (`drupal/ai`) is a *runtime* requirement, not an info.yml dependency — every AI-backed
  extractor calls `\Drupal::service('ai.provider')` and self-disables (via `isAvailable()`) when no
  provider is configured for the operation it needs. No API key or HTTP client lives in this module.
- **Config:** one object `advanced_filesystem_ai_transcription.settings` (schema + install defaults).
  → [config/settings.md](config/settings.md)
- **Plugin type it provides:** `SemanticExtractor` (annotation + manager + base + interface) with
  **11 extractors**. → [plugins/semantic-extractors.md](plugins/semantic-extractors.md)
- **Services / QueueWorker / hooks:** transcription, semantic, embedding and tagging services; the
  `adfs_ai_transcription` cron queue worker; upload/entity trigger hooks; Drush commands.
  → [api/services.md](api/services.md)
- **Fields, media source, routes:** the `adfs_ai_` file fields, the `adfs_ai_transcription` media
  source, and the six admin routes/controllers. → [media/fields-and-source.md](media/fields-and-source.md)

## What it actually is (from source)

- **SemanticExtractor plugin type.** `Annotation/SemanticExtractor.php` (id, label, `mime_types[]`
  glob patterns, int `weight`); `SemanticExtractorPluginManager` scans `Plugin/SemanticExtractor/`,
  alter hook `adfs_semantic_extractor_info`, `getSortedDefinitions()` orders by weight;
  `SemanticExtractorBase` implements MIME matching + a default single-method; `SemanticExtractorInterface`
  defines `applies()/extract()/isAvailable()/extractionMethods()/extractByMethod()`. Each `extract()`
  returns a `SemanticResult` value object (fulltext, summary, tags, entities, embedding, image
  fields, `skipped`, `merge()`, `hasData()`); the plugin never saves the file — that is the service's
  job.
- **11 extractors** (id → label): `audio_transcription`, `video_transcription`, `image_captioning`,
  `image_analysis`, `image_face_emotion`, `image_safety`, `pdf_ocr`, `office_document`,
  `text_extraction`, `ai_taxonomy_tagging`, `embeddings`. All AI work goes through drupal/ai
  operation types (`speech_to_text`, `chat_with_image_vision`, `chat`, `object_detection`,
  `embeddings`). Audio/video also shell out to **ffmpeg/ffprobe** (via `escapeshellarg`), PDF to
  **pdftoppm/pdftotext**, Office to a native ZIP reader or **libreoffice**.
- **Services** (`*.services.yml`): `...service` (`TranscriptionService`), `...semantic_service`
  (`SemanticExtractionService`, the orchestrator), `...embedding_service` (`EmbeddingService` — VDB +
  cosine/PCA), `...taxonomy_tagging_service` (`AiTaxonomyTaggingService`), `...field_manager`
  (`TranscriptionFieldManager` — creates the `adfs_ai_` fields on install), and the
  `...plugin_manager.semantic_extractor`.
- **Triggers** (`.module`): `hook_file_insert` (global `auto_transcribe`), `hook_entity_insert/update`
  (per-field `enabled_fields`), both enqueue to the `adfs_ai_transcription` queue processed by
  `Plugin/QueueWorker/TranscriptionWorker` (cron, `time = 60`, state-tracked failure backoff).
- **Fields:** `TranscriptionDefinitions` declares ~25 `adfs_ai_*` file fields in four groups
  (ai_transcription, semantic, embedding, image_analysis); created by `TranscriptionFieldManager`.
- **Media:** `Plugin/media/Source/AiTranscriptionSource` (id `adfs_ai_transcription`) maps six
  `adfs_ai_` fields as media metadata attributes.
- **Routes** (all `_permission: 'administer advanced_filesystem_ai_transcription'`, `_admin_route`):
  `settings`, `dashboard` (`TranscriptionController`), `batch` (`BatchExtractionForm`),
  `embedding_map` (`EmbeddingMapController`), per-file `file_extract` (`SingleFileExtractionForm`) and
  `file_view` (`FileSemanticViewController`).

## Permissions

- `administer advanced_filesystem_ai_transcription` — **restricted**; gates all six routes, the
  entity-operation link, and the settings.
- `trigger advanced_filesystem_ai_transcription` — non-restricted; intended for queueing files for
  transcription (not attached to an anonymous route).

## Drush

`Commands/TranscriptionCommands.php` (via `drush.services.yml`) — batch/single transcription and
semantic extraction over managed files. → [api/services.md](api/services.md)
