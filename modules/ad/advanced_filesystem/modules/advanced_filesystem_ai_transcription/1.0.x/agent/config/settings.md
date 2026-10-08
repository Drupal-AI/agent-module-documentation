<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — advanced_filesystem_ai_transcription.settings

Single config object, form `Form\TranscriptionSettingsForm` at
**`/admin/config/media/advanced_filesystem/ai-transcription`** (route
`advanced_filesystem_ai_transcription.settings`, permission
`administer advanced_filesystem_ai_transcription`, `_admin_route`). Schema in
`config/schema/advanced_filesystem_ai_transcription.schema.yml`; install defaults in
`config/install/advanced_filesystem_ai_transcription.settings.yml`.

## Install & enable

```bash
# The parent project ships this as a submodule; enable it directly.
drush en advanced_filesystem_ai_transcription -y
```

`hook_install()` calls `TranscriptionFieldManager::ensureAll()` to create the `adfs_ai_*` fields on
the `file` entity (and, via update hooks 9004/9005, the default taxonomy vocabularies
`adfs_ai_tags`, `adfs_ai_objects`, `adfs_ai_category`, `adfs_ai_brands`). `hook_uninstall()` deletes
all `adfs_ai_` field storages (cascading to stored data) and the settings object. AI features stay
inert until a `drupal/ai` provider is configured — extractors report themselves unavailable
otherwise.

## Keys (config_object)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `provider_id` | string | *(unset)* | AI provider id for speech_to_text. When empty, drupal/ai's default provider for the operation is used. |
| `model_id` | string | *(unset)* | Model id for transcription. |
| `language` | string | *(unset)* | Default BCP-47 language hint passed to the transcription provider. |
| `max_file_size_mb` | integer | `25` | Reject audio/video larger than this before calling the AI (cost guard). `0` = no limit. |
| `auto_transcribe` | boolean | `false` | Transcribe audio/video automatically on upload (see triggers below). |
| `extract_audio_sample_rate` | integer | `16000` | Sample rate (Hz) for the ffmpeg-extracted audio track; clamped to 8000–48000 at runtime. |
| `enabled_fields` | sequence<string> | `[]` | `entity_type.bundle.field_name` file fields whose new files trigger transcription. When non-empty, per-field triggers replace the global `auto_transcribe` path. |
| `embedding_provider_id` | string | `''` | AI provider id for the `embeddings` operation. |
| `embedding_model_id` | string | `''` | Embedding model id. |
| `vdb_provider_id` | string | `'mariadb'` | Vector-database provider plugin id (from the AI VDB providers) used to index embeddings. |
| `vdb_collection` | string | `'advanced_filesystem_files'` | VDB collection name to index into. |
| `extractor_matrix` | mapping | see below | Per-MIME-group on/off toggles for each extractor family. |
| `tagging` | mapping | `{enabled:false, vocabulary:'adfs_ai_tags', mime_rules:[]}` | AI taxonomy-tagging settings. |

The form also reads/writes some `image_analysis.*` keys (per-dimension `*_use_taxonomy` /
`*_vocab`) and an `embedding_max_chars` and `enabled_extractors` value that the extractors consult;
these are set through the form though not all appear in the base install YAML.

### extractor_matrix

Mapping of MIME group → extractor → boolean, for groups `audio`, `video`, `image`, `pdf`, `text`,
`other`. Extractor keys: `audio_transcription`, `image_captioning`, `pdf_ocr`, `text_extraction`,
`embeddings`. Install defaults enable speech-to-text for audio/video, captioning for images, OCR for
pdf, and text extraction for text; everything else off. `EmbeddingExtractor::applies()` and
`SemanticExtractionService` read this matrix to decide which extractors run for a given file's group.

### tagging

`enabled` (bool), `vocabulary` (machine name, default `adfs_ai_tags`), `mime_rules`
(sequence<string> of MIME patterns that gate tagging). `AiTaxonomyTaggingService` reads these; the
default vocabulary is auto-created by `ensureVocabulary()`.

## Triggers (`.module`)

- **Global:** `hook_file_insert` — when `auto_transcribe = true` **and** `enabled_fields` is empty,
  any newly uploaded `audio/*` or `video/*` file is queued.
- **Per-field:** `hook_entity_insert` / `hook_entity_update` — for each `enabled_fields` entry
  matching the saved entity's type+bundle, newly referenced audio/video files are queued
  (`hook_entity_update` diffs against `$entity->original` so existing files are not re-queued).
- Both paths call `_adfs_ai_transcription_queue_file()`, which creates an `adfs_ai_transcription`
  queue item `{fid, overwrite:false}` and sets `adfs_ai_transcript_status = 'pending'` (guarded
  against re-entrancy). The queue is drained by `TranscriptionWorker` on cron.

## Example config export

```yaml
# advanced_filesystem_ai_transcription.settings
max_file_size_mb: 25
auto_transcribe: true
extract_audio_sample_rate: 16000
enabled_fields:
  - 'media.audio.field_media_audio_file'
embedding_provider_id: 'openai'
embedding_model_id: 'text-embedding-3-small'
vdb_provider_id: 'mariadb'
vdb_collection: 'advanced_filesystem_files'
extractor_matrix:
  audio:  { audio_transcription: true,  image_captioning: false, pdf_ocr: false, text_extraction: false, embeddings: true }
  image:  { audio_transcription: false, image_captioning: true,  pdf_ocr: false, text_extraction: false, embeddings: true }
  pdf:    { audio_transcription: false, image_captioning: false, pdf_ocr: true,  text_extraction: false, embeddings: false }
tagging:
  enabled: true
  vocabulary: 'adfs_ai_tags'
  mime_rules: []
```
