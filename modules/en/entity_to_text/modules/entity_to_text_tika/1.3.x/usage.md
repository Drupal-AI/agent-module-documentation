<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity to Text - Tika extracts plain text (including OCR) from managed files by sending them to an Apache Tika server.

---

This submodule of Entity to Text ships a `FileToText` service that connects to an Apache Tika server (host and port read from `settings.php` under `entity_to_text_tika.connection`) and returns the extracted text of a managed file, with a configurable OCR language such as `eng` or `eng+fra`. A `PreProcessFileEvent` lets other code alter the Tika client or the file just before extraction. A `LocalFileStorage` service caches the extracted text as `.ocr.txt` files under `private://entity-to-text/ocr`, keyed by file id, filename and langcode, so repeated calls avoid re-hitting Tika. A Drush command, `drush e2t:t:w` (`entity_to_text:tika:warmup`), batch-generates that cache across all files with options for MIME filtering, file-id targeting, size thresholds and forced re-processing. A runtime requirements check reports whether the private file system is available for the cache. It requires the base module, core `file`, the `vaites/php-apache-tika` library, and a reachable Tika server; it provides no routes, permissions, config entities, or config schema.

---

- Extract plain text from an uploaded PDF, Word, Excel, or image file via `entity_to_text_tika.extractor.file_to_text`.
- Run OCR over scanned documents or photographed pages in a chosen language.
- Extract multilingual text with a combined OCR langcode such as `eng+fra`.
- Configure the Tika connection in `settings.php` (`$settings['entity_to_text_tika.connection']['host'|'port']`).
- Cache extracted text on disk to avoid repeated Tika calls with `entity_to_text_tika.storage.local_file`.
- Load a previously cached OCR result with `LocalFileStorage::load($file, $langcode)`.
- Save an OCR result for reuse with `LocalFileStorage::save($file, $content, $langcode)`.
- Prepare the private OCR storage directory with `prepareStorage()` (e.g. from `hook_install`).
- Warm the OCR cache for every file after a fresh install with `drush e2t:t:w`.
- Re-process all files ignoring the cache with `drush e2t:t:w --force`.
- Warm OCR for a single file by id with `drush e2t:t:w --fid=2`.
- Limit warmup to specific MIME types with `drush e2t:t:w --filemime=application/pdf`.
- Skip documents above a size threshold with `drush e2t:t:w --filesize-threshold=1000000`.
- Do a trial pass without processing using `drush e2t:t:w --dry-run`.
- Persist empty OCR results to avoid reprocessing unprocessable files with `--save-empty-ocr`.
- Stop the batch on the first failure (e.g. Tika down) with `--stop-on-failure`.
- Alter the Tika client options or swap the file before extraction via the `entity_to_text_tika.preprocess_file` event.
- Index extracted document text into Solr or Elasticsearch.
- Feed document contents into an AI knowledge base or embeddings pipeline.
- Extract attachment text during a content migration or feed import.
- Make binary document contents searchable on the site.
