<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Extract Data (web_extract_data) — agent index

**Scrapes images/links/meta from a CSV list of URLs and exports XLSX reports.**

- **Version:** 1.0.x (release 1.0.1)
- **Core:** ^10 || ^11  ·  **Depends:** `drupal:phpspreadsheet`
- **Routes:** `web_extract_data.import_form` (`/web_extract_data/form`, upload form) and `web_extract_data.export` (`/report-export/{type}`, file download) — BOTH require `administer site configuration`.
- **Service:** `web_extract_data.import` → `ImportManagerService` (`makeCall`/`coreCall` fetchers, `exportImageReport`/`exportUrlReport`/`exportMetaReport` PhpSpreadsheet writers).
- **Form:** `ExtractWebData` — managed CSV upload + report-type select; Batch runs `handleExtractType()` (DOMDocument parse); reports written to `public://tmp/`.
