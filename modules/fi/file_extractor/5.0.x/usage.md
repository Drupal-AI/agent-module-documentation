<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Extractor extracts the text content of uploaded file entities (PDF, Office docs, etc.) using a pluggable set of extractor backends (pdftotext, Apache Tika CLI/server, docconv, a Python pdf2txt script, or Search API Solr), exposing the result as a computed field and a field formatter so document text can be displayed or indexed.

---

The module adds a computed base field `file_extractor_extracted_file` to every `file` entity (via `hook_entity_base_field_info`) and a file field formatter `file_extractor_extracted_text` that renders the extracted text of an uploaded document. Extraction is orchestrated by the `ExtractorManager` service: given a file it checks the file is indexable (exists, permanent, MIME not in the excluded-extensions list, under the max size, and — optionally — not private), dispatches a `FileIndexableEvent` so other modules can veto, then runs the configured extractor plugin and caches the result permanently in a dedicated `file_extractor` cache bin (keyed by file id + a hash of the result-affecting settings, invalidated by the file's cache tags and the settings config). A global settings form (`/admin/config/media/file-extractor`, permission `file_extractor_administer_settings`, which is `restrict access: true`) picks the active extraction method, its per-plugin settings (binary/host paths), and the extraction settings (excluded extensions, max file size, exclude-private, and max extracted bytes). A companion Test form runs the chosen method against a bundled sample PDF. Extractor plugins are discovered by the `FileExtractorExtractor` PHP attribute under `Plugin/file_extractor/Extractor`, each declaring optional module/Composer-package dependencies that hide it when unmet. The CLI-based extractors (pdftotext, docconv, python_pdf2txt, tika) invoke external binaries through `symfony/process` using **array-form arguments** (no shell), with binary paths supplied only through the restricted admin settings form; tika_server and search_api_solr talk to a configured service. Extraction results are byte-limited (`number_first_bytes`, default 1 MB) and mb-cut.

---

- Extract the text of an uploaded PDF and display it via the "File Extractor: extracted file" formatter.
- Feed extracted document text into Search API for full-text indexing of attachments.
- Index the contents of Word/Office documents using Apache Tika.
- Use the standalone `pdftotext` binary to pull text out of PDFs.
- Run Apache Tika as a local JAR (CLI) for broad file-format coverage.
- Talk to a running Tika JAX-RS server over HTTP instead of spawning Java per file.
- Extract PDF text with a Python `pdf2txt.py` (pdfminer) script.
- Use docconv (`docd`) to convert documents to text.
- Reuse an existing Search API Solr server's Tika extract handler to extract file content.
- Exclude image/audio/video extensions from extraction attempts (default excludes aif, avi, gif, png, flv, …).
- Cap extraction to files under a chosen size to avoid processing huge uploads.
- Exclude private-scheme files from extraction for privacy.
- Limit the amount of extracted text stored/cached (e.g. first 1 MB) per file.
- Override global extraction settings per field-formatter instance.
- Add a computed extracted-text value to file entities for use in Views or custom code.
- Let another module veto whether a specific file is indexable via the `FileIndexableEvent`.
- Test the current extraction configuration against a bundled sample PDF from the admin UI.
- Write a custom extractor plugin for a new backend by extending `ExtractorPluginBase`.
- Gate an extractor plugin behind a required module or Composer package so it only appears when available.
- Cache extraction results so re-rendering a document does not re-run the extractor.
- Display document text inline on a node alongside the file download link.
- Migrate legacy extracted-text field/formatter/Views/Layout Builder settings via the shipped update hooks.
- Programmatically extract a file's text by calling `ExtractorManager::extract($file)`.
- Apply different extraction limits for search indexing vs. on-page display via `setExtractionSettings()`.
