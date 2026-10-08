<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Views Data Export (views_data_export_tcpdf) — agent index

**Adds a TCPDF-rendered `pdf` export format to Views Data Export, with header/footer/logo/metadata options.**

- **Version:** 1.0.x  (info.yml `1.0.0-beta1`)
- **Core:** ^9 || ^10 || ^11  •  **Depends on:** views_data_export  •  **Library:** TCPDF in `libraries/`
- **Encoder:** `Drupal\views_data_export_tcpdf\Encoder\Pdf` (service tag `encoder`, format `pdf`) — `src/Encoder/Pdf.php`
- **PDF class:** `src/Pdf/CustomPdf.php` (extends `\TCPDF`, custom `Header()`/`Footer()`)
- **Style/display:** `src/Plugin/views/style/PdfDataExport.php`, `src/Plugin/views/display/PdfDataExport.php` (overrides `data_export`)
- **Extras:** `PdfExportForm` (upload/merge a PDF), `ExportRedirectSubscriber`, auto-download JS

**Security:** Export is served through a Views Data Export display, so access is whatever that display's access plugin is set to — set it deliberately (not left open) for sensitive data. No SSRF/RCE surface found: every cell/header value is `strip_tags()` + `Html::escape()` before reaching `writeHTML()`, so no attacker-controlled `<img src>` or HTML reaches TCPDF; the header logo is a local `realpath()` of a selected managed file entity (no remote URL fetch). `pdf_settings` (metadata/header/footer) are admin-configured on the view. Note: `ExportRedirectSubscriber` references an undeclared `$this->fileStorage` (a bug, not a security finding).

See [configure/export.md](configure/export.md)
