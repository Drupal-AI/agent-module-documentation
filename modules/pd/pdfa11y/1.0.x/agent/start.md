<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDFa11y (pdfa11y) — agent index

Checks PDF files attached to **Media** entities for accessibility compliance. On media
insert/update the module parses the `.pdf` source file **locally** with `smalot/pdfparser`
(no external service, no shell-out), runs a configurable set of check plugins, and stores
per-check pass/fail/error rows in the `pdfa11y_results` table. Results surface on a per-media
"Accessibility" tab, a media-view status badge, and a site-wide Views report. Uploads that fail
can be warned or hard-blocked via a validation constraint. A Drush command and a queue worker
batch-check an existing library.

Requires core `media` + `file`; Composer `smalot/pdfparser ^2.0`; PHP `>=8.1`; core `^10.2 || ^11`.
Configure at `pdfa11y.settings` → `/admin/config/media/pdf-accessibility`.
Defines 5 permissions, a Drush command, a plugin type, a queue worker, Views data, and config schema.

- **Change which checks run / warn vs block / size caps** → [configure/settings.md](configure/settings.md)
- **Who can configure, run, view, bypass** → [permissions/permissions.md](permissions/permissions.md)
- **Batch-check existing PDFs from the CLI** → [drush/commands.md](drush/commands.md)
- **Add a custom accessibility check (plugin type)** → [plugins/accessibility-check.md](plugins/accessibility-check.md)
- **Call the analyzer / parser / preflight services** → [api/services.md](api/services.md)
- **Upload blocking, media triggers, queue, alter hook** → [hooks/hooks.md](hooks/hooks.md)
- **The Views report + field/filter plugins** → [views/views.md](views/views.md)

Key facts:
- Config object `pdfa11y.settings` keys: `enabled_checks` (list of plugin ids), `min_pdf_version`,
  `check_on_upload`, `block_failed_uploads`, `editor_instructions`, `max_consecutive_io_failures`,
  `skip_missing_files`, `max_filesize`, `max_image_bytes`, `use_subprocess_isolation`,
  `subprocess_memory_headroom`. Second object `pdfa11y.help` key `help_content` (HTML).
- Services: `Drupal\pdfa11y\Pdfa11yAnalyzer`, `Drupal\pdfa11y\PdfParserService`,
  `Drupal\pdfa11y\PdfPreflightService`, `plugin.manager.pdfa11y_check`, `pdfa11y.entity_hooks`,
  `pdfa11y.media_access_check`, `logger.channel.pdfa11y`.
- Plugin type: **AccessibilityCheck** — manager `plugin.manager.pdfa11y_check`
  (`AccessibilityCheckManager`), attribute `Drupal\pdfa11y\Attribute\AccessibilityCheck`,
  interface/base `AccessibilityCheckInterface` / `AccessibilityCheckBase`, namespace
  `Plugin/AccessibilityCheck`, alter hook `pdfa11y_check_info`. 6 built-in ids: `tagged_pdf`,
  `heading_structure`, `document_title`, `document_title_filename`, `document_language`, `pdf_version`.
- Permissions: `administer pdf accessibility` (restrict), `run pdf accessibility checks`,
  `view pdf accessibility reports`, `view pdf accessibility help`,
  `bypass blocked pdf uploads` (restrict).
- Drush: `pdf-accessibility:check` (alias `pa:check`). Queue worker id `pdfa11y_check` (cron).
- Routes: `pdfa11y.settings`, `pdfa11y.help` (`/admin/config/media/pdf-accessibility/help`),
  `pdfa11y.media_report` (`/media/{media}/accessibility`),
  `pdfa11y.media_recheck` (`/media/{media}/accessibility/recheck`, CSRF-protected).
- DB table `pdfa11y_results` (fid, mid, check_id, status, severity, message, uid, checked).
  Sentinel `check_id`s for skip outcomes: `_missing_file`, `_parse_error`, `_encrypted_pdf`,
  `_io_error`, `_too_large`, `_image_payload_too_large`, `_subprocess_failed`.
- Optional Views config `views.view.pdfa11y_report`; report pages under `admin/reports/pdf-accessibility`.
