<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fields, media source, routes & UI

## The `adfs_ai_*` file fields (`TranscriptionDefinitions`)

`TranscriptionDefinitions::getFields()` declares ~25 base fields on the **`file`** entity, created by
`TranscriptionFieldManager::ensureAll()`. `getGroups()` buckets them into four display groups.

- **ai_transcription:** `adfs_ai_transcript` (string_long), `adfs_ai_transcript_lang` (string),
  `adfs_ai_transcript_status` (list_string: pending/processing/done/failed/…),
  `adfs_ai_transcript_provider` (string).
- **semantic:** `adfs_ai_fulltext` (string_long, primary text), `adfs_ai_summary` (string_long),
  `adfs_ai_tags` (string, cardinality -1), `adfs_ai_entities_json` (string_long),
  `adfs_ai_confidence` (decimal), `adfs_ai_extractor_id` (string).
- **embedding:** `adfs_ai_embedding` (string_long JSON float[]), `adfs_ai_embedding_model` (string),
  `adfs_ai_vdb_collection` (string), `adfs_ai_vdb_indexed` (boolean).
- **image_analysis:** `adfs_ai_objects` / `adfs_ai_category` / `adfs_ai_brands`
  (entity_reference→taxonomy_term), `adfs_ai_colors` (string, max 7, cardinality -1, hex e.g.
  `#1a3c5e`), `adfs_ai_safety_score` / `adfs_ai_faces_json` / `adfs_ai_emotions_json` (string_long),
  `adfs_ai_image_caption` (string_long), `adfs_ai_objects_json` (string_long).

Because these are real Drupal fields they appear in **Views** and the Field UI with no extra
integration. (Update hook `9006` changed `adfs_ai_colors` from entity_reference to string — a
storage-type change that drops any previously stored color term references.)

## Media source (`Plugin/media/Source/AiTranscriptionSource.php`)

`#[MediaSource(id: 'adfs_ai_transcription', label: 'File (ADFS AI Transcription)',
allowed_field_types: ['file'])]`, extends core `media` `Source\File`. `getMetadataAttributes()` adds
six attributes → `getMetadata()` returns the matching `adfs_ai_` field value from the source file:
`adfs_ai_fulltext`, `adfs_ai_summary`, `adfs_ai_tags`, `adfs_ai_confidence`, `adfs_ai_extractor_id`,
`adfs_ai_image_caption`. Create a media type with this source to map AI metadata onto media fields.

## Routes & controllers (`*.routing.yml`)

All six routes require **`_permission: 'administer advanced_filesystem_ai_transcription'`** (a
`restrict access: true` permission) and are `_admin_route: true`. There is **no** anonymous or
low-privilege route; the paid-AI actions (batch/single extraction) are admin-only.

| Route | Path | Handler |
|---|---|---|
| `.settings` | `/admin/config/media/advanced_filesystem/ai-transcription` | `Form\TranscriptionSettingsForm` |
| `.dashboard` | `…/ai-transcription/dashboard` | `Controller\TranscriptionController::dashboard` |
| `.batch` | `…/ai-transcription/batch` | `Form\BatchExtractionForm` |
| `.embedding_map` | `…/ai-transcription/embedding-map` | `Controller\EmbeddingMapController::map` |
| `.file_extract` | `/admin/content/files/{file}/semantic-extract` | `Form\SingleFileExtractionForm` |
| `.file_view` | `/admin/content/files/{file}/ai-transcription` | `Controller\FileSemanticViewController::view` |

`{file}` is `type: entity:file` with a `\d+` requirement.

- **`TranscriptionController::dashboard()`** — coverage stats, recent files, failed extractions. Row
  cells that echo file data (`filename`, `filemime`, status label, extractor id, text preview) are
  `htmlspecialchars(…, ENT_QUOTES)`-escaped before going into `#markup`.
- **`FileSemanticViewController::view()`** — per-file detail grouped by the four field groups.
  `formatFieldValue()` escapes every value branch (single value, long-text `<details>`, multi-value
  tags, entity_reference labels, JSON pretty-print, confidence) with `htmlspecialchars`. The embedding
  group adds a heatmap "fingerprint", stats (dims / L2 norm / min-max-mean / near-zero%), a collapsed
  raw-vector textarea, and a **most-similar-files** gallery (cosine similarity; a `?similar=N` query,
  int-cast and clamped to {6,12,24,48}). Filenames and file URLs in the gallery are escaped.
- **`EmbeddingMapController::map()`** — a 2D PCA scatter (inline SVG) of up to 400 embeddings; each
  point links to the file's detail page; filenames and legend labels are escaped.
- **`SingleFileExtractionForm`** — renders each extractor's `extractionMethods()` as buttons and runs
  the chosen method; **`BatchExtractionForm`** runs the pipeline over many files.

## How to operate

1. `drush en advanced_filesystem_ai_transcription -y` (creates the `adfs_ai_*` fields).
2. Install & configure a `drupal/ai` provider for the operations you need (`speech_to_text`,
   `chat_with_image_vision`, `chat`, `embeddings`, optionally `object_detection`) and set it as the
   default in Admin → Config → AI.
3. At `…/ai-transcription`, set the extractor matrix, size limit, language, tagging and (for
   embeddings) the embedding provider/model + VDB provider/collection. Optionally turn on
   `auto_transcribe` or list `enabled_fields`.
4. Run extraction: per file (`…/ai-transcription` tab → "Run / re-run"), in batch, via Drush, or
   automatically on upload (cron drains the `adfs_ai_transcription` queue).
5. Review results per file, browse the embedding map, or expose the `adfs_ai_*` fields in Views /
   Media.
