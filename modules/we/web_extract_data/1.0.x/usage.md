<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Extract Data crawls a batch of URLs listed in an uploaded CSV, extracts image tags, anchor links or meta tags from each fetched page, and writes the results to a downloadable XLSX spreadsheet.
---
An admin uploads a CSV and picks a report type at `/web_extract_data/form` (permission `administer site configuration`). The submit handler loads the file, parses the first column of each row into a URL list, and runs a Batch: for each URL `handleExtractType()` fetches the page (`ImportManagerService::coreCall()` via cURL), parses it with `DOMDocument`, and collects `<img>` / `<a>` / `<meta>` data. On finish the matching exporter (`exportImageReport` / `exportUrlReport` / `exportMetaReport`) uses PhpSpreadsheet to build `image-report.xlsx`, `url-report.xlsx` or `seo-meta-report.xlsx` in `public://tmp/`. A second route `/report-export/{type}` (`ExportController`) streams that file back as an attachment.

Generated reports live in the public files directory.
---
- Upload a CSV of URLs at `/web_extract_data/form`.
- Extract all `<img>` sources, alt and title from each page.
- Extract all `<a>` links, titles and link text from each page.
- Extract all `<meta>` name/content tags from each page.
- Generate an `image-report.xlsx` spreadsheet.
- Generate a `url-report.xlsx` spreadsheet.
- Generate a `seo-meta-report.xlsx` spreadsheet.
- Download a generated report via `/report-export/{type}`.
- Process many URLs via the Drupal Batch API.
- Restrict access with `administer site configuration`.
- Audit outbound links across a set of pages.
- Collect image inventories for an SEO review.
- Harvest meta descriptions/keywords for auditing.
- Style report headers/rows via PhpSpreadsheet.
- Store reports under `public://tmp/`.
- Fetch pages with cURL (`coreCall`) during the batch.
- Feed the XLSX output into downstream analysis tools.