<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, queue worker, hooks & Drush

All services are declared in `advanced_filesystem_ai_transcription.services.yml` and share the
logger channel `logger.channel.advanced_filesystem_ai_transcription`.

## Services

- **`advanced_filesystem_ai_transcription.service`** — `Service\TranscriptionService`
  (`@file_system`, `@config.factory`, logger). Speech-to-text for audio/video.
  - `transcribe(FileInterface, array $options)`: for video, optionally reuse an embedded subtitle
    track (`extractEmbeddedSubtitles()` via `ffprobe`/`ffmpeg`); else `extractAudioTrack()` runs
    `ffmpeg -i <esc> -vn -ar <rate> -ac 1 -codec:a libmp3lame … <escOut>` (rate clamped 8000–48000,
    all paths `escapeshellarg`'d), enforces `max_file_size_mb`, reads bytes, and delegates to the
    AI `speech_to_text` provider (`callProvider()`).
  - `transcribeAndSave(FileInterface, bool $overwrite, array $options)`: full pipeline; writes
    `adfs_ai_transcript` / `adfs_ai_transcript_status='done'` / `adfs_ai_transcript_provider`; static
    re-entrancy guard; logs and rethrows on failure. Temp MP3 files are `@unlink`ed in `finally`.
- **`…semantic_service`** — `Service\SemanticExtractionService` (`@…plugin_manager.semantic_extractor`,
  `@config.factory`, logger, `@event_dispatcher`, `@…embedding_service`). The orchestrator: picks the
  applicable+available extractors for a file (per `enabled_extractors` + `extractor_matrix`), runs
  them in weight order, dispatches `PreExtractionEvent`/`PostExtractionEvent`, `merge()`s
  `SemanticResult`s and `storeResult()`s each populated `adfs_ai_*` field (honouring `overwrite`).
- **`…embedding_service`** — `Service\EmbeddingService` (`@config.factory`, logger). Indexes vectors
  into the configured VDB provider (`vdb_provider_id`/`vdb_collection`), decodes stored JSON vectors,
  computes cosine similarity (`findSimilar()`), loads all embeddings and projects them to 2D
  (`projectPca2d()`) for the map.
- **`…taxonomy_tagging_service`** — `Service\AiTaxonomyTaggingService` (`@config.factory`,
  `@entity_type.manager`, logger). `ensureVocabulary()` creates the tag vocabularies; resolves AI
  label strings to `taxonomy_term` ids; MIME-rule gating; `DEFAULT_VOCABULARY = 'adfs_ai_tags'`.
- **`…field_manager`** — `TranscriptionFieldManager` (`@entity_type.manager`, logger).
  `ensureAll()` creates every `adfs_ai_*` field storage+instance on the `file` entity from
  `TranscriptionDefinitions`; `deleteAll()` removes them on uninstall. Driven by `hook_install` and
  the `update_9001`–`update_9006` hooks.
- **`…plugin_manager.semantic_extractor`** — the `SemanticExtractor` manager (see
  [../plugins/semantic-extractors.md](../plugins/semantic-extractors.md)).

## Events (`src/Event/`)

`SemanticExtractionEvents` (constants), `PreExtractionEvent` and `PostExtractionEvent` — dispatched
around extraction so other modules can alter inputs or react to results.

## Queue worker (`Plugin/QueueWorker/TranscriptionWorker.php`)

`@QueueWorker(id="adfs_ai_transcription", title="AI Semantic Extraction", cron={"time"=60})`.
Constructed with the semantic service, entity type manager, logger and `@state`. Processes each
`{fid, overwrite}` item: loads the file, runs the semantic pipeline, and tracks per-item failure
counts in state for backoff (so a permanently failing file is not retried forever).

## Trigger hooks (`.module`)

- `hook_file_insert` — global auto-transcribe (`auto_transcribe && enabled_fields empty`), audio/video
  only.
- `hook_entity_insert` / `hook_entity_update` — per-field triggers driven by `enabled_fields`
  (`entity_type.bundle.field_name`); update path diffs `$entity->original` to skip pre-existing files.
- `hook_entity_operation` — adds an "AI Transcription" op link on `/admin/content/files` for users
  with `administer advanced_filesystem_ai_transcription`.
- Helper `_adfs_ai_transcription_queue_file()` enqueues `{fid, overwrite:false}` and sets status
  `pending`.

## Drush (`drush.services.yml` → `Commands\TranscriptionCommands`)

Constructed with the transcription service + semantic service. Provides batch and single-file
transcription / semantic-extraction commands over managed files (filtering on
`adfs_ai_transcript_status`), for scripted or scheduled runs. Run `drush list --filter=advanced_filesystem`
to see the exact command names on your install.
