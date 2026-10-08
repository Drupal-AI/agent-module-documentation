<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Manager (pdf_manager) — agent index

**Admin tool to scan the site for PDFs (database + physical), bulk-download them as ZIP, export CSV, and replace PDFs.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10 || ^11`
- **Config route:** `pdf_manager.admin` → `/admin/content/pdf-manager`.
- **Routes (all permission `administer pdf manager`, restricted):** `scan` (GET), `download` (POST), `clear-cache`, `batch-download` (POST), `download-csv` (POST), `upload-pdf` (POST), `upload-csv`.
- **Service:** `pdf_manager.service` (`PdfService`).

**Security:** All routes gated by the restricted `administer pdf manager` permission (admin-only). NOTE (post-auth, low severity): `download`/`createBulkDownload()` trust a request-supplied `path` for "physical" files and add any readable file at that path to the ZIP without restricting it to Drupal file dirs — an admin can thus download arbitrary server-readable files (`src/Service/PdfService.php` `createBulkDownload()`, `src/Controller/PdfController.php::download()`). Reachable only by trusted admins; ideally the path should be validated against the scanned set.

See [api/pdf_manager.md](api/pdf_manager.md).
