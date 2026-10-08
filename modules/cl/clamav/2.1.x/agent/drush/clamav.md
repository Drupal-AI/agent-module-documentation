# ClamAV Drush

## `clamav:scan-files` (alias `cav-sf`)

Batch-scans **all existing permanent managed files** (`file_managed` rows with
`STATUS_PERMANENT`) through the configured ClamAV backend — useful for retroactively checking
a library uploaded before ClamAV was enabled. Runs as a progressive batch.

```bash
drush clamav:scan-files              # scan all permanent managed files (batch size 50)
drush clamav:scan-files --batch-size=5
drush cav-sf                         # alias
```

- `--batch-size` — files per batch operation (default `50`).
- Each file is loaded, its real path resolved via the file system; inaccessible files are counted as **unchecked**.
- On finish it reports counts of clean / infected / unchecked files.
- Files are scanned in place via the `clamav` service's `scan()` (which logs infections and, per settings, clean/unchecked results). The command reports results; it does not delete infected files.

Defined by `Drupal\clamav\Drush\Commands\ClamavCommand` (registered in `drush.services.yml`,
injecting `@entity_type.manager`, `@clamav`, `@file_system`).
