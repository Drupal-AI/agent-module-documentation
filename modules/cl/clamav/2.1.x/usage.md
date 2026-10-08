ClamAV Anti-Virus integrates Drupal's file uploads with the ClamAV anti-virus scanner, scanning every uploaded managed file and rejecting (or optionally allowing) infected or unscannable files.

---

The module hooks into Drupal's core file-validation event (`FileValidationEvent`): every `File` entity is flagged for scanning at creation (`hook_entity_create`), and when that file is validated the `clamav.file_validation_subscriber` runs it through ClamAV. It connects to ClamAV in one of three configurable scan modes — a ClamAV daemon over TCP/IP (default), a ClamAV daemon over a Unix socket, or the local `clamscan` executable — each implemented as a small scanner class selected by the `scan_mode` setting. Infected files add a constraint violation (upload blocked, file deleted); a configurable "outage action" decides whether files that could not be checked (service unreachable) are blocked or allowed through. Scanning is scoped by stream-wrapper scheme: by default all local schemes (public, private, temporary) are scanned and remote schemes are not, and this can be overridden per scheme in the settings form. The `hook_clamav_file_is_scannable()` hook lets other modules force-scan or exempt individual files (e.g. skip images or huge files). A verbosity toggle logs clean/skipped files in addition to the always-logged infections, and a Drush command (`clamav:scan-files`) batch-scans all existing permanent managed files. A runtime requirements check reports the connected ClamAV version (or an error) on the status report.

---

- Scan every file uploaded through Drupal forms (nodes, media, webforms, user pictures) for viruses before it is stored.
- Block upload of files ClamAV detects as infected and automatically delete them.
- Connect Drupal to a ClamAV daemon over TCP/IP (default: `localhost:3310`).
- Connect Drupal to a ClamAV daemon over a Unix socket (e.g. `/var/clamav/clamd`).
- Use the local `clamscan` executable when no daemon is available (default `/usr/bin/clamscan`).
- Pass custom parameters to `clamscan`, e.g. `--max-recursion=10`, in executable mode.
- Choose fail-open vs fail-closed behavior when ClamAV is unavailable ("Allow" vs "Block" unchecked files).
- Restrict scanning to specific stream-wrapper schemes (scan `private://` but not a remote CDN, etc.).
- Enable scanning of a remote stream wrapper that is normally skipped by overriding its scheme.
- Exempt image files (or any MIME type) from scanning via `hook_clamav_file_is_scannable()`.
- Skip scanning of very large files to avoid PHP timeouts, per-file, via the scannable hook.
- Force scanning of specific high-risk files even when defaults would skip them.
- Deliberately allow known-infected files for security researchers via the scannable hook.
- Batch-scan the entire existing managed-file library retroactively with `drush clamav:scan-files`.
- Tune the retroactive scan throughput with `drush clamav:scan-files --batch-size=5`.
- Log all infected uploads to the Drupal log (dblog/watchdog) with the detected virus name.
- Enable verbose logging to record clean and skipped files for auditing.
- Surface the running ClamAV version on the Status Report page via the runtime requirements check.
- Turn anti-virus scanning on or off site-wide with a single `enabled` toggle.
- Gate access to the ClamAV configuration form with the `administer clamav` permission.
- Call the `clamav` service programmatically to scan a `File` entity from custom code.
- Check whether a scheme is scannable from code via `Scanner::isSchemeScannable()`.
- Present a clear violation message to end users when a file cannot be scanned and uploads are blocked.
- Protect user-generated content sites (forums, communities) from malware distribution through uploads.
- Meet compliance requirements that mandate anti-virus scanning of all inbound file uploads.
