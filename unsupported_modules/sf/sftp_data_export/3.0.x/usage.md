<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SFTP Data Export builds a CSV of chosen fields from nodes of a content type and pushes it to a remote SFTP server over SSH2.

---

Administration is under `/admin/config/services/sftp_settings/*`: `content_config` chooses which fields per bundle to export, `credentials` stores the SFTP host/port/username/password, and `export` runs the export. A Batch API process (`ExportBatch::exportCsvCallback`) loads nodes in chunks, formats each field via `SftpHelper::getNodeFields()` (handling image, list, timestamp and link field types), and appends rows to `public://sftp/<bundle>_<date>.csv`. On completion, `exportBatchFinishedCallback` opens an `ssh2_connect`/`ssh2_auth_password` session and streams the CSV to `Files/<count>_<date>.csv` on the remote host. The module requires the PHP `ssh2` extension.

Security-relevant behavior for operators: all three routes are gated only by the broad `_permission: 'access administration pages'` — not by the module's own `administer sftp` permission (which is defined but unused) — so any role with generic admin access can view/change SFTP credentials and trigger exports. The SFTP username and password are stored in plain configuration (`sftp_data_export.cred`), so they are exportable with config and the password is pre-filled back into the form field. The generated CSV is written to the WEB-ACCESSIBLE `public://sftp/` directory with a predictable `<bundle>_<date>.csv` name and is not deleted, potentially exposing exported content. The SSH2 connection does not verify the server host key (no fingerprint check), leaving it open to MITM. Typical setup: enable the module (with ext-ssh2), pick fields per bundle, enter SFTP credentials, then run the export.

---

- Export nodes of a content type to CSV.
- Choose exactly which fields per bundle are exported.
- Upload the generated CSV to a remote SFTP server.
- Store SFTP host, port, username and password.
- Run the export as a batch over large node sets.
- Format image fields to their file URI in the CSV.
- Resolve list (string/int/float) fields to their allowed-value labels.
- Format created/timestamp fields as `m/d/Y H:i:s`.
- Export link-field URIs.
- Schedule periodic data hand-off to a partner system.
- Deliver catalog/content extracts to an external server.
- Filter out reference/map/metatag/uuid fields from the field picker.
- Verify SFTP connectivity by running an export.
- Name the uploaded file by record count and date.
- Produce a `<bundle>_<date>.csv` under the files directory.
- Integrate Drupal content into an ETL pipeline.
- Re-export after content updates.
- Restrict who can configure the export (via permissions).
- Append multiple chunks into a single CSV during batch.
- Hand structured node data to a legacy reporting system.
