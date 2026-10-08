<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity to Text is a developer-focused suite of helper services that turn Drupal content (node fields, Paragraphs, and uploaded files) into clean plain-text strings.

---

Entity to Text provides utility/helper APIs for developers, not an end-user UI. The base module ships a `NodeToText` extractor service that renders a single node field with its default formatter and then runs the HTML through an `HTMLPurifier` configuration that strips every tag and CSS property, yielding trimmed plain text. The `entity_to_text_paragraphs` submodule adds a `ParagraphsToText` service that renders each referenced Paragraph in `full` view mode to plain text. The `entity_to_text_tika` submodule adds a `FileToText` service that sends managed files to an Apache Tika server for text extraction / OCR, a `LocalFileStorage` service that caches the extracted text as `.ocr.txt` files under `private://entity-to-text/ocr`, and a Drush command (`drush e2t:t:w`) to batch-warm that cache. The suite is aimed at feeding text into search indexes (Solr, Elasticsearch), embeddings/AI pipelines, SEO/JSON-LD, and migrations. It has no routes, permissions, config entities, or config schema; the Tika connection is read from `settings.php`.

---

- Extract the plain-text value of a single node field with `entity_to_text.extractor.node_to_text` service's `fromFieldtoText($field_name, $node)`.
- Flatten a rich-text `body` field into indexable plain text for Solr or Elasticsearch.
- Build the `text` payload for a vector-embedding pipeline from node field content.
- Generate plain-text summaries of entity fields for AI/LLM prompt context.
- Produce plain-text field values for SEO metadata or JSON-LD structured data.
- Strip all HTML and CSS from formatted field output using the reusable `entity_to_text.htmlpurifier` service.
- Convert each Paragraph in a paragraph-reference field to plain text with `entity_to_text_paragraphs.extractor.paragraphs_to_text`.
- Render layered Paragraphs content (`full` view mode) into an array of clean text blocks for indexing.
- Extract text from uploaded PDF, Word, Excel, or image files via Apache Tika with `entity_to_text_tika.extractor.file_to_text`.
- Run OCR over scanned documents and images in a chosen language (e.g. `eng+fra`).
- Cache extracted OCR text on disk to avoid repeated Tika calls using `entity_to_text_tika.storage.local_file`.
- Pre-generate OCR for every file after a fresh install with `drush e2t:t:w`.
- Re-process all files (ignoring the cache) with `drush e2t:t:w --force`.
- Warm OCR for a single file by id with `drush e2t:t:w --fid=2`.
- Restrict OCR warmup to specific MIME types with `drush e2t:t:w --filemime=application/pdf`.
- Skip oversized documents during warmup with `drush e2t:t:w --filesize-threshold=1000000`.
- Alter the Tika client or file just before extraction by subscribing to the `entity_to_text_tika.preprocess_file` event.
- Add OCR text to a search index during file migration or import.
- Feed document contents from attachments into an AI knowledge base.
- Prepare the private OCR storage directory programmatically with `prepareStorage()` (e.g. from a module `hook_install`).
- Combine node-field text and Paragraph text into a single indexed document.
- Use the extracted text as input for automatic tagging or classification.
