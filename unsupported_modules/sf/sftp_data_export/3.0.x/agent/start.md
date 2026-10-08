<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SFTP Data Export (sftp_data_export) — agent index

**Exports selected node fields per bundle to a CSV and uploads it to a remote SFTP server over SSH2.**

- **Version:** 3.0.x (project `sftp_export`; machine name `sftp_data_export`)
- **Core:** ^9 || ^10 || ^11 · requires PHP `ext-ssh2`
- **Routes (all `_permission: access administration pages`):** `.../content_config` (field selection), `.../credentials` (SFTP creds), `.../export` (run).
- **Permission defined but UNUSED:** `administer sftp`.
- **Service:** `sftp_data_export.csv_export` (`ExportBatch`); helper `SftpHelper`.
- **Output:** `public://sftp/<bundle>_<date>.csv`, then SFTP-uploaded to `Files/<count>_<date>.csv`.

**Security (flag to operators):** (1) credential + export routes are gated only by the broad `access administration pages`, not the unused `administer sftp` permission; (2) SFTP username/password stored plaintext in config `sftp_data_export.cred`; (3) CSV written to web-accessible `public://sftp/` with predictable name, not deleted; (4) SSH2 connection performs no host-key verification (MITM risk).

See [configure/sftp_data_export.md](configure/sftp_data_export.md)
