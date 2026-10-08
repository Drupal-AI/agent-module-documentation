<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Extractor — agent index

Extracts text from uploaded file entities via pluggable backends (pdftotext, Tika CLI/server, docconv,
Python pdf2txt, Search API Solr). Exposes a computed base field on `file` entities and a
`file_extractor_extracted_text` file formatter. Depends on core `file`; CLI extractors need
`symfony/process`. Provides one plugin type, a config schema, and one permission. No Drush.

- **Global settings form, config keys, extraction settings, the Test form** →
  [configure/settings.md](configure/settings.md)
- **The 6 built-in extractor plugins (config + how they run) and how to write your own** →
  [plugins/extractors.md](plugins/extractors.md)
- **`ExtractorManager` service, the computed field, the formatter, `FileIndexableEvent`, caching** →
  [api/extract.md](api/extract.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `file_extractor.settings`: `extraction_method`, `extraction_method_settings`,
  `extraction_settings` (`extractable.{excluded_extensions,max_filesize,exclude_private}` +
  `extraction_result.number_first_bytes`).
- Settings route `file_extractor.settings_form` at `/admin/config/media/file-extractor`; test route
  `/admin/config/media/file-extractor/test`. Both require `file_extractor_administer_settings`
  (`restrict access: true`).
- Plugin type: attribute `Drupal\file_extractor\Attribute\FileExtractorExtractor`, base
  `ExtractorPluginBase`, discovered under `Plugin/file_extractor/Extractor`, manager
  `plugin.manager.file_extractor.extractor`, alter hook `file_extractor_extractor_info`.
- Computed base field on `file`: `file_extractor_extracted_file`; formatter id `file_extractor_extracted_text`.
- CLI extractors spawn binaries with `symfony/process` using **array args (no shell)**; binary paths come
  only from the restricted admin settings.
