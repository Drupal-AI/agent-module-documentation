Scans uploaded files for malware with ClamAV and blocks, warns about or quarantines infected uploads, with bulk scanning and a detection log.

---

Advanced Filesystem: Antivirus (machine name `advanced_filesystem_antivirus`) plugs ClamAV into Drupal's upload pipeline. The `ClamAvScanner` service can stream file bytes to the clamd daemon using the INSTREAM protocol over a TCP or Unix socket (recommended, since the daemon never needs to read the file from disk), or shell out to the `clamdscan` / `clamscan` binaries via `proc_open`. On every new upload an `AntivirusFileValidator` subscriber to the core `FileValidationEvent` runs a scan and, depending on the configured action, blocks the upload (adding a validation error and moving the file to a quarantine directory), shows a warning, or silently logs the detection; a `fail_closed` setting decides whether files that cannot be scanned are rejected. Detections are stored in a log table, can be forwarded to the Webhooks sub-module, and are written to the parent module's audit trail. Existing files can be scanned in bulk via a Batch form or the `adfs:av:scan` Drush command. It depends on the parent `advanced_filesystem` module and `file`, and is administered through one restricted permission.

---

- Scan every uploaded file for viruses before it becomes a permanent managed file.
- Block infected uploads outright and quarantine the file (default `on_infection: block`).
- Warn the user but keep the upload when you prefer detection over hard blocking.
- Log-only mode: record detections without blocking or warning, for monitoring first.
- Stream files to a clamd daemon over TCP (`host:port`, default 127.0.0.1:3310) for fast resident scans.
- Talk to clamd over a Unix domain socket for local daemon setups.
- Fall back to the `clamdscan` binary (uses the running daemon) when sockets are not available.
- Use the standalone `clamscan` binary on hosts without a daemon (slower — reloads the signature DB per file).
- Reject uploads when the scanner is unreachable by enabling the `fail_closed` (fail-secure) toggle.
- Skip scanning of very large files with a configurable maximum scan size (MB).
- Quarantine infected files to a private directory (default `private://antivirus_quarantine`).
- Bulk-scan all existing managed files through the "Scan Existing Files" batch form.
- Scan files from the CLI: `drush adfs:av:scan --limit=100` or `--fid=123`.
- Verify ClamAV connectivity and signature-DB version with `drush adfs:av:ping`.
- Review a detection log of clean / infected / error / skipped scans with signatures and messages.
- Prune old scan-log rows automatically on cron using a retention window (days).
- Forward infection events to the Advanced Filesystem Webhooks sub-module when it is installed.
- Record infection detections in the parent module's audit log for compliance.
- Check the loaded virus-database freshness from the settings page before trusting scans.
- Notify content teams by wiring quarantine events into downstream alerting via webhooks.
