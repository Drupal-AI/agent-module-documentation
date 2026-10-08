Backs up the site's file trees (public://, private:// and other local stream wrappers) to Local, FTP/FTPS, Amazon S3, Cloudflare R2 or Google Cloud Storage — as a ZIP archive or file-by-file — with cron scheduling, retention, restore and download.

---

Advanced Filesystem: Backup is a file-backup engine for the Advanced Filesystem suite. It scans the stream-wrapper schemes you select, applies glob exclusions, and ships the result to one or more pluggable storage backends. Five backends ship in the box: a Local filesystem copy, FTP/FTPS via PHP's native functions, and three S3-compatible cloud targets — Amazon S3, Cloudflare R2 and Google Cloud Storage — all sharing a hand-rolled AWS Signature v4 signer over Drupal's HTTP client. Two backup modes cover different site sizes: ZIP mode packs everything into a single chunked archive (needs temp disk), while file-by-file mode streams each file directly to the backend with no temporary archive. Runs execute through the Batch API (interactive, with a progress bar), a phased queue worker (background, survives PHP timeouts), or cron on a schedule, and a state lock stops two runs colliding. A dashboard shows run history, live progress, and per-run download/restore/delete actions; retention automatically trims old archives per backend. Restore re-downloads and rebuilds files back to their original URIs. Everything is behind one restricted admin permission.

---

- Nightly cron backup of public:// files to an Amazon S3 bucket.
- Back up both public:// and private:// to Cloudflare R2 with a folder key prefix.
- Push archives to Google Cloud Storage using interoperability (HMAC) keys.
- Copy backups to an FTPS server or mounted NAS via the Local/FTP backends.
- Keep a local private:// copy plus an off-site cloud copy in the same run.
- Choose ZIP mode for small sites (<5 GB) to get a single downloadable archive.
- Choose file-by-file mode for large sites to avoid needing temp disk equal to the backup size.
- Exclude image-style derivatives, temp and log files with glob patterns.
- Run an on-demand interactive backup with a live progress bar from the dashboard.
- Queue a background backup and drain it immediately with "Process queue now" (no cron wait).
- Schedule automatic backups hourly, daily, weekly or monthly on cron.
- Enforce retention: keep only the last N archives per backend and auto-delete older ones.
- Download any completed backup archive straight from the run-history table.
- Restore a backup with an age-warning and an explicit overwrite confirmation.
- Force-reset a stuck/locked run and release the backup lock.
- Cancel an in-progress backup from the dashboard.
- Tune memory/throughput by setting how many files are processed per batch/queue chunk.
- Back up any local stream wrapper (custom scheme) that appears in the scheme list.
- Store cloud archives under a custom key prefix to isolate them from other bucket content.
- Point the temp-archive directory at a volume with sufficient free space.
- Review run history with status, file counts, archive size and expandable error details.
- Add a new storage backend type by implementing the BackupStorage plugin interface.
- Test a backend's connectivity before enabling it for real runs.
- Serve a local backup archive directly (no copy) when downloading, for efficiency.
