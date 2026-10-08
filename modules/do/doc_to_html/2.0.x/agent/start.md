<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOC to HTML (doc_to_html) — agent index
**Converts DOC/DOCX uploads to HTML with LibreOffice and injects the result into CKEditor 5 text fields.**

- **version:** 2.0.x
- **core:** ^10.1 || ^11 (php >=8.1)
- **depends on:** drupal:file, drupal:text
- **configure:** `doc_to_html.basic_settings` → `/admin/config/content/doc_to_html/basic-settings`
- **routes:** basic-settings, libreoffice-settings, test-wizard — all `administer doc to html settings` (`restrict access: true`).
- **widget:** `DocToHtmlWidget`; services `ConversionManager`, `CmdService` (LibreOffice), `MarkupService`, `FileService`, `FileCleaner`; events `Pre/PostConvertEvent`; Drush command.
- **permissions:** `administer doc to html settings`, `use doc to html widget`.
- **Security (reviewed sound):** shell command built with `escapeshellcmd()`+`escapeshellarg()` and run via `proc_open` with timeout — no command injection; admin routes access-restricted; MIME validation on uploads.

See [configure/setup.md](configure/setup.md)
