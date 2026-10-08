Scans managed file content for personal-data patterns (CPF, CNPJ, e-mail, credit card, IBAN, etc.) and records redacted findings in a review workflow to help with LGPD/GDPR compliance.

---

The LGPD/GDPR File Auditor is a sub-module of Advanced Filesystem that reads the content of permanent managed files and matches a fixed catalogue of personal-data regular expressions against it. Each unique match is stored as a redacted finding (only the first four characters are kept, the rest becomes asterisks) in a dedicated table, and every scanned file is tracked so re-runs skip work already done. Scans run either interactively through the Batch API or in the background through a queue drained by cron or Drush. A filterable results page with per-type summaries, CSV export and a per-finding review workflow (pending / reviewed / dismissed, plus free-text reviewer notes) lets a compliance team triage what was found. The module is detection-only: it never edits, moves or deletes the files it scans. Every route is gated behind the core "administer site configuration" permission.

---

- Detect Brazilian CPF numbers stored inside uploaded spreadsheets, CSVs or text exports.
- Detect Brazilian CNPJ company registration numbers in managed files.
- Detect Brazilian RG identity-document numbers.
- Detect Brazilian phone numbers (mobile and landline formats).
- Detect e-mail addresses embedded in file content.
- Detect credit/debit card numbers (Visa, Mastercard, Amex, Discover/Elo patterns).
- Detect IPv4 addresses that may constitute personal data under GDPR.
- Detect generic international passport identifiers.
- Detect IBAN bank-account numbers.
- Choose exactly which pattern categories to scan for, grouped into Brazil, General, International and Metadata sets.
- Run an on-demand scan with a live browser progress bar via the Batch API.
- Cap the number of files scanned per batch and the files processed per batch step.
- Enqueue all scannable files for unattended background processing via the queue.
- Enable automatic scheduled scanning that enqueues unscanned files on each cron run.
- Throttle automatic scanning with a configurable minimum interval (default once per day).
- Re-scan already-scanned files on demand to pick up newly enabled patterns.
- Skip files larger than a configurable maximum size to protect memory.
- Drain the scan queue immediately with `drush queue:run advanced_filesystem_lgpd_scan`.
- Review findings in a filterable table by data type, workflow status and filename.
- See a summary bar counting pending findings per personal-data type.
- Export the current filtered finding set to CSV for an auditor or DPO.
- Mark a finding reviewed, dismissed, or reset it to pending as triage proceeds.
- Attach internal reviewer notes to a finding to document why it is acceptable or what was remediated.
- Track which files have already been scanned to avoid duplicate findings.
- Monitor scan status (scannable file count, findings on record, queue depth, last cron/last batch time) from the settings page.
