<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EsPipelineExtractor — Search API Attachments text extractor

File: `src/Plugin/search_api_attachments/EsPipelineExtractor.php`
Class: `Drupal\es_attachment\Plugin\search_api_attachments\EsPipelineExtractor` extends `search_api_attachments\TextExtractorPluginBase`.

## Annotation
```
@SearchApiAttachmentsTextExtractor(
  id = "es_pipeline_extractor",
  label = "ElasticSearch Pipeline Extractor",
  description = "Use ElasticSearch pipeline attachment."
)
```
It is one of the extraction-method options Search API Attachments offers. Select it at the Search API Attachments admin config (extraction method), which stores the value in config `search_api_attachments.admin_config` key `extraction_method` = `es_pipeline_extractor`.

## Behavior
- `extract(File $file)`: reads the file URI via `$file->getFileUri()`, `file_get_contents($path)`, then returns `base64_encode($data)`. It does **not** parse the document in PHP — it ships the raw bytes (base64) so the Elasticsearch ingest pipeline's `attachment` processor performs the real text extraction. (Source `@todo` notes `Crypt::hashBase64` was reverted to plain `base64_encode`, and flags a performance note for large files.)
- `buildConfigurationForm()`: renders only the markup "No config needed". The extractor has no settings.

## Consequence for the index
Because this "extractor" emits base64 rather than plain text, the stored per-file value is a base64 blob; the text you actually search lives at `<field>.attachment.content` after the ingest pipeline runs (see `events/pipeline-and-events.md`). The QueryEvent excludes those raw file fields from query `_source`, so the base64 blob is not returned in results.

This extractor is only meaningful when the index's server backend is Elasticsearch Connector and the `es_attachment` pipeline exists; enabling the extractor triggers `UpdateIndexSettingsEvent` to build that pipeline.
