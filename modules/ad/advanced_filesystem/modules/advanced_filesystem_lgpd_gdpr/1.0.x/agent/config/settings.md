<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LGPD/GDPR Auditor — settings

Config object **`advanced_filesystem_lgpd_gdpr.settings`** (schema:
`config/schema/advanced_filesystem_lgpd_gdpr.schema.yml`, install defaults:
`config/install/advanced_filesystem_lgpd_gdpr.settings.yml`). Edited by
`LgpdAuditorSettingsForm` at `/admin/config/media/lgpd-auditor/settings`
(route `advanced_filesystem_lgpd_gdpr.settings`, `_permission: 'administer site configuration'`).

## Install / enable

```bash
drush pm:install advanced_filesystem_lgpd_gdpr
drush cr
```

Requires the parent `advanced_filesystem` plus core `file` and `system`. `hook_schema` (in
`.install`) creates `advanced_filesystem_lgpd_findings` and `advanced_filesystem_lgpd_scanned`;
`update_10001` back-fills them if a prior mis-named schema hook left them missing.

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `patterns` | mapping (pattern_id => bool) | `{}` | Enabled detection patterns. Empty map = all patterns enabled (see `getEnabledPatterns()`). |
| `cron_enabled` | bool | `false` | Enqueue unscanned files on cron. |
| `cron_interval` | int (s) | `86400` | Minimum seconds between cron enqueue runs. |
| `cron_chunk_size` | int | `20` | Files per queue item. |
| `cron_rescan` | bool | `false` | Re-scan already-scanned files on each cron cycle. |
| `max_file_size_mb` | int (MB) | `20` | Skip files larger than this (0 = no limit). |
| `ocr_enabled` | bool | `false` | OCR image scanning toggle (see caveat). |
| `ocr_languages` | string | `por+eng` | Tesseract language codes; validated against `/^[a-zA-Z][a-zA-Z0-9_+\-]*$/`, else reset to `por+eng`. |
| `ocr_skip_low_quality` | bool | `true` | Skip images below the minimum dimensions. |
| `ocr_min_width` | int (px) | `300` | Minimum image width for OCR. |
| `ocr_min_height` | int (px) | `300` | Minimum image height for OCR. |

## Pattern catalogue

`LgpdFileScanner::PATTERNS` (constant, not config) defines the available patterns and their
`group` (used only to lay out the settings form): **br** — `cpf`, `cnpj`, `rg`, `br_phone`;
**general** — `email`, `credit_card`, `ip_address`; **international** — `passport`, `iban`.
The settings form splits these into "Brazil (LGPD)", "General", "International" and
"File & Image Metadata" checkbox groups, then merges the four groups back into one
`{id => bool}` map on submit.

## Cron behaviour

`AdvancedFilesystemLgpdGdprHooks::advancedFilesystemLgpdCron()` returns immediately unless
`cron_enabled` is true and `getRequestTime() - state('…last_cron') >= cron_interval`. When it
runs it records `last_cron` in state and calls `LgpdFileScanner::enqueueAll($cron_rescan,
$cron_chunk_size)`, which chunks scannable fids into the `advanced_filesystem_lgpd_scan` queue.
`LgpdScanWorker` (`cron = {"time"=30}`) then drains the queue on subsequent cron runs.

## OCR caveat

The OCR fields are stored and `LgpdFileScanner::isOcrAvailable()` runs `which tesseract` to
enable/disable them in the form. In this release the scan path (`scanFile()` → `readFileSafe()`)
processes text-scannable MIME types only; it does not shell out to Tesseract or pdftotext, so the
OCR options have no runtime effect on the actual scan.
