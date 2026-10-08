<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Manager scans a Drupal site for PDF files and lets administrators bulk-download, export and replace them from one admin screen.
---
The problem it solves: PDFs accumulate both as managed file entities and as loose files on disk, with no easy way to inventory or export them. PDF Manager scans both sources, de-duplicates, and presents a single management UI.

How it works: `PdfService::scanPdfs()` combines a managed-file query (filemime `application/pdf`, status 1) with a recursive filesystem scan of `public://`, `private://` and the default files directories (excluding cache/temp/vendor dirs), merges and sorts them, and caches results for 15 minutes. `PdfController` exposes JSON endpoints to scan, bulk-download selected files as a ZIP (`createBulkDownload()`), export scan results to CSV, clear the cache, and upload a replacement PDF matched against a previously uploaded CSV mapping. Every route requires the restricted `administer pdf manager` permission (`restrict access: true`), so the tool is admin-only.

Security note: the bulk-download accepts a `path` value from the request body for "physical" files and adds any existing, readable file at that path to the ZIP without confining it to Drupal's file directories — an administrator can therefore download arbitrary server-readable files. This is only reachable with the restricted `administer pdf manager` permission (post-authentication, trusted admins), so severity is low, but the path should ideally be validated against the scanned file set.

Setup: enable the module, grant `administer pdf manager` to trusted admins only, and use `/admin/content/pdf-manager` to scan and manage PDFs.
---
- Scan the whole site for PDF files in one click.
- Inventory both managed (database) and loose (physical) PDFs.
- See total PDF count and combined size.
- Bulk-download selected PDFs as a single ZIP.
- Export the PDF scan results to a CSV file.
- Clear the cached scan results on demand.
- Upload a CSV mapping of filenames to URLs.
- Replace an existing PDF file with a new upload.
- De-duplicate files that exist both on disk and in the database.
- Exclude cache/temp/vendor directories from the scan.
- Cache scan results for 15 minutes for performance.
- Restrict all operations to the `administer pdf manager` permission.
- Enforce a 50MB limit and PDF MIME check on replacement uploads.
- Batch large bulk downloads via the batch API.
- Generate per-user named ZIP archives in the temp directory.
- Audit failures through the `pdf_manager` logger channel.
