<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pdf_manager — endpoints & operation

Base UI: `/admin/content/pdf-manager` (`PdfManagerForm`). All routes require `administer pdf manager` (restricted, admin-only).

| Route | Method | Purpose |
|---|---|---|
| `pdf_manager.scan` | GET | `PdfService::scanPdfs()`; JSON count/size/files; cached 15 min (`pdf_manager:scan_results`). |
| `pdf_manager.download` | POST | Body `{files:[{fid}|{path,filename}]}`; returns a ZIP (`BinaryFileResponse`). |
| `pdf_manager.batch_download` | POST | Batch API bulk download for large sets. |
| `pdf_manager.download_csv` | POST | Body `{files:[...]}`; returns a CSV of the scan results. |
| `pdf_manager.clear_cache` | GET/POST | Deletes the cached scan results. |
| `pdf_manager.upload_csv` | POST | Stores `fid` in state `pdf_manager.csv_fid`. |
| `pdf_manager.upload_pdf` | POST | Uploads a replacement PDF (MIME `application/pdf`, ≤50MB), matched via `validateCsvFileAndPDFName()` against the CSV, then replaces the target file. |

Scan sources: managed files (`filemime=application/pdf`, `status=1`) plus a recursive scan of `public://`, `private://` and `sites/default/files[/private]`, excluding `php/styles/css/js/temp/tmp/cache/logs/.git/.svn/node_modules/vendor`.

Security caveat: for `{path}` entries `createBulkDownload()` adds any existing readable path to the ZIP with no confinement to Drupal file dirs → arbitrary server-file disclosure for holders of `administer pdf manager`. Grant that permission only to trusted admins; consider validating requested paths against the scan output.
