# Configure PDFa11y

Form `\Drupal\pdfa11y\Form\Pdfa11ySettingsForm` at route `pdfa11y.settings` →
`/admin/config/media/pdf-accessibility` (permission `administer pdf accessibility`). Edits two
config objects: `pdfa11y.settings` and `pdfa11y.help`.

## `pdfa11y.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_checks` | list<string> | all 6 ids | Which check plugin ids run. Order is the plugin ids present, not weight. |
| `min_pdf_version` | string | `'1.4'` | Minimum `%PDF-x.y` version the `pdf_version` check requires. Form validates format `X.Y` and range 1.0–3.0. |
| `check_on_upload` | bool | `true` | Master switch. When false, no upload-time analysis, warnings, or blocking happens. |
| `block_failed_uploads` | bool | `false` | When true, a failing PDF cannot be saved (constraint violations). When false, only warnings are shown. |
| `editor_instructions` | string (HTML) | link to help page | Shown to editors under upload warnings and on the report when a file fails. Rendered as `#markup`. |
| `max_consecutive_io_failures` | int | `10` | Queue circuit-breaker: suspend `pdfa11y_check` after this many consecutive `_io_error` items. `0` disables. |
| `skip_missing_files` | bool | `false` | When true, orphaned media (source file absent) is skipped without writing a `_missing_file` row. |
| `max_filesize` | int (bytes) | `10485760` (10 MB) | Files at/over this size are recorded `_too_large` and never handed to smalot. `0` disables. Coarse OOM backstop. |
| `max_image_bytes` | int (bytes) | `52428800` (50 MB) | Estimated decompressed image-payload cap (via `PdfPreflightService`); over it records `_image_payload_too_large`. `0` disables. Primary OOM guard. |
| `use_subprocess_isolation` | bool | `true` | Parse each file in a forked child (`pcntl_fork`) so an uncatchable OOM fatal ends only the child (records `_subprocess_failed`). No-op without `pcntl`. |
| `subprocess_memory_headroom` | string | `'128M'` | Extra `memory_limit` granted to the isolated child on top of the parent limit. `'0'` inherits unchanged. |

`pdfa11y.help` has one key: `help_content` (HTML shown at `/admin/config/media/pdf-accessibility/help`).
The settings form also edits this via its "Help page content" section.

## Set via drush / PHP

```bash
drush config:set pdfa11y.settings block_failed_uploads true -y
drush config:set pdfa11y.settings min_pdf_version 1.7 -y
```

```php
$config = \Drupal::configFactory()->getEditable('pdfa11y.settings');
$config
  ->set('enabled_checks', ['tagged_pdf', 'heading_structure', 'document_title', 'document_language', 'pdf_version'])
  ->set('check_on_upload', TRUE)
  ->set('block_failed_uploads', FALSE)
  ->set('max_image_bytes', 100 * 1024 * 1024)
  ->save();
```

## What happens at runtime

Analysis runs when `check_on_upload` is true and a media entity's source field accepts `pdf`
extensions and the file URI ends `.pdf`. `Pdfa11yAnalyzer::analyze()` calls
`PdfParserService::parse($uri)` → `file_get_contents($uri)` on the Drupal stream URI, then
`smalot/pdfparser`'s `Parser::parseContent()` **in-process** (no external service). Each enabled
plugin's `check(Document, $uri)` returns a pass/fail/error `AccessibilityCheckResult`;
`not_applicable` results are dropped before insert. Results replace prior rows for that `fid`
inside a transaction (`storeResults()` / `pdfa11y_results` table).

Config schema: `config/schema/pdfa11y.schema.yml` (`pdfa11y.settings` as `config_object`,
`pdfa11y.help` as `config_object`).
