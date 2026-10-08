<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The SemanticExtractor plugin type + the 11 extractors

## Plugin type

- **Annotation** `Annotation/SemanticExtractor.php` (extends `Plugin`): `id` (string), `label`
  (Translation), `mime_types` (string[] glob patterns, e.g. `{"audio/*","video/mp4"}`), `weight`
  (int; lower runs first).
- **Manager** `SemanticExtractorPluginManager` (service
  `advanced_filesystem_ai_transcription.plugin_manager.semantic_extractor`): `DefaultPluginManager`
  over subdir `Plugin/SemanticExtractor`, interface `SemanticExtractorInterface`, annotation
  `SemanticExtractor`; alter hook **`adfs_semantic_extractor_info`**; cache key
  `adfs_semantic_extractor_plugins`. `getSortedDefinitions()` sorts by ascending weight.
- **Base** `Plugin/SemanticExtractor/SemanticExtractorBase` (extends `PluginBase`): implements
  `applies()` (fnmatch of the file MIME against the annotation's `mime_types`), `label()`, and a
  default single `extractionMethods()`/`extractByMethod()` that delegate to `extract()`.
- **Interface** `SemanticExtractorInterface`: `applies(FileInterface): bool`,
  `extract(FileInterface): SemanticResult`, `description(): string`, `isAvailable(): bool`,
  `unavailableReason(): string`, `extractionMethods(): array` (each `{id,label,description,fields[],
  requires_ai}`), `isMethodAvailable($id)`, `methodUnavailableReason($id)`,
  `extractByMethod(FileInterface,$id): SemanticResult`. **Extractors MUST NOT save the file** — they
  only build a result; `SemanticExtractionService::storeResult()` writes fields.
- **Result** `SemanticResult` (value object): `fulltext`, `summary`, `tags[]`, `entities[]`,
  `confidence`, `language`, `extractorId`, `providerId`; embedding block (`embedding[]`,
  `embeddingModel`, `vdbIndexed`, `vdbCollection`); image blocks (`taxonomyTermIds[]`,
  `objectTermIds[]`, `categoryTermId`, `colorHexValues[]`, `brandTermIds[]`, `safetyScoreJson`,
  `facesJson`, `emotionsJson`, `imageCaption`, `objectsJson`); `skipped`; `merge(other)`, `hasData()`.

To add a custom extractor: create a class in your module's `Plugin/SemanticExtractor/` with the
`@SemanticExtractor` annotation, extend `SemanticExtractorBase`, implement `extract()` (and
`isAvailable()` if AI/binary-backed). It is discovered automatically and ordered by `weight`.

## AI delegation (important)

No extractor makes a direct HTTP call, holds a key, or sets a TLS option. Each obtains
`\Drupal::service('ai.provider')` (`AiProviderPluginManager`), checks
`getDefaultProviderForOperationType(<op>)` for availability, then `createInstance($providerId)` and
calls the operation. Operation types used: `speech_to_text`, `chat_with_image_vision`, `chat`,
`object_detection`, `embeddings`. All credential/endpoint/TLS handling belongs to drupal/ai.

## The 11 extractors (`Plugin/SemanticExtractor/`)

| id | class | mime_types | AI op / tooling | Populates |
|---|---|---|---|---|
| `audio_transcription` | `AudioTranscriptionExtractor` | `audio/*` | `speech_to_text` | fulltext / transcript, language |
| `video_transcription` | `VideoTranscriptionExtractor` | `video/*` | ffmpeg subtitle reuse → `speech_to_text` | transcript |
| `image_captioning` | `ImageCaptioningExtractor` | image/jpeg,png,webp,gif,avif | `chat_with_image_vision` | imageCaption, tags |
| `image_analysis` | `ImageAnalysisExtractor` | image/jpeg,png,webp,gif,avif | `chat_with_image_vision` + native `object_detection` | objects/category/colors/brands, objectsJson |
| `image_face_emotion` | `ImageFaceEmotionExtractor` | image/jpeg,png,webp,gif,avif | `chat_with_image_vision` | facesJson, emotionsJson |
| `image_safety` | `ImageSafetyExtractor` | image/jpeg,png,webp,gif,avif | `chat_with_image_vision` | safetyScoreJson |
| `pdf_ocr` | `PdfOcrExtractor` | application/pdf | pdftotext (native) / pdftoppm → `chat_with_image_vision` OCR | fulltext |
| `office_document` | `OfficeDocumentExtractor` | DOCX/XLSX/PPTX/ODF | native ZIP reader / libreoffice CLI | fulltext |
| `text_extraction` | `TextExtractionExtractor` | text/* + more | native read → `chat` enrich | fulltext, summary, tags |
| `ai_taxonomy_tagging` | `AiTaxonomyTaggingExtractor` | `*` | `chat` | taxonomyTermIds (into a vocabulary) |
| `embeddings` | `EmbeddingExtractor` | `*` (matrix-gated) | `embeddings` | embedding vector + VDB index |

Notes from source:
- **Audio/video** use `TranscriptionService`: video first tries an embedded subtitle track
  (`ffprobe`+`ffmpeg`, no AI cost) unless the caller forces AI; otherwise ffmpeg extracts a mono MP3
  at the clamped sample rate, size is checked against `max_file_size_mb`, then bytes go to the
  provider. All shell arguments pass through `escapeshellarg()`; the sample rate is int-clamped.
- **Image extractors** read the managed file's own bytes (`file_get_contents(realpath)`), base64 them
  into an `ImageFile`/`ChatMessage`, and parse a JSON response (`json_decode`), mapping labels to
  taxonomy terms via `AiTaxonomyTaggingService`.
- **PdfOcr** prefers `pdftotext -layout`; for scanned PDFs it rasterises pages with
  `pdftoppm -jpeg` and sends each image to the vision provider. **Office** unzips DOCX/XLSX/PPTX XML
  natively or falls back to `libreoffice --headless` conversion. Both `escapeshellarg()` every path.
- **Embeddings** builds text from `adfs_ai_fulltext`/`adfs_ai_summary`, truncates to
  `embedding_max_chars`, calls the `embeddings` op, stores the JSON vector in `adfs_ai_embedding`, and
  (when a `vdb_provider_id` is set) indexes it via `EmbeddingService` into the configured collection.

## Orchestration

`Service\SemanticExtractionService` selects matching+available extractors for a file (respecting
`enabled_extractors` and `extractor_matrix`), runs them in weight order, `merge()`s the results, and
`storeResult()` writes each populated `adfs_ai_*` field (honouring the `overwrite` flag). The
`SingleFileExtractionForm` exposes each extractor's `extractionMethods()` as individual buttons;
`BatchExtractionForm` and the Drush commands run the pipeline over many files.
