# ClamAV Anti-Virus — agent index

Scans Drupal file uploads through the ClamAV anti-virus engine. Files are flagged
at entity-create and scanned during core's file-validation event; infected files
are rejected and deleted. Config lives in `clamav.settings`; UI at
`/admin/config/media/clamav` (route `clamav.admin_display`).

- [Configure](configure/clamav.md) — scan modes (daemon TCP/IP, Unix socket, executable), settings keys, outage behavior, scannable schemes.
- [API](api/clamav.md) — the `clamav` scanner service, `Scanner` result constants, file-validation integration.
- [Hooks](hooks/clamav.md) — `hook_clamav_file_is_scannable()` to include/exclude files.
- [Drush](drush/clamav.md) — `clamav:scan-files` to batch-scan existing managed files.
- [Permissions](permissions/clamav.md) — `administer clamav`.
