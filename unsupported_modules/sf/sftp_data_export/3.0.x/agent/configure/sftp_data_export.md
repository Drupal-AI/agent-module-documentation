<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring SFTP Data Export

## Prerequisite
PHP `ssh2` extension must be installed (`ssh2_connect`, `ssh2_auth_password`, `ssh2_sftp`).

## Steps
1. **Fields** — `/admin/config/services/sftp_settings/content_config`: select which fields of each bundle to export (`SettingsForm`; reference/map/metatag/uuid/comment fields are filtered out by `SftpHelper::getCleanFields()`).
2. **Credentials** — `/admin/config/services/sftp_settings/credentials`: host, port, username, password (`CredentialForm`, saved to config `sftp_data_export.cred`).
3. **Export** — `/admin/config/services/sftp_settings/export`: runs the batch (`UploadForm`).

## Runtime (`ExportBatch`)
- `exportCsvCallback` chunks nids, maps fields via `SftpHelper::getNodeFields()`, appends rows to `public://sftp/<bundle>_<date>.csv`.
- `exportBatchFinishedCallback` connects via SSH2 and `stream_copy_to_stream`s the CSV to `Files/<count>_<date>.csv` on the remote host.

## Operator hardening notes
- Routes use `access administration pages`; the module's own `administer sftp` permission is never applied — consider tightening.
- Credentials are plaintext config; the CSV in `public://sftp/` is web-accessible and not cleaned up.
- No SSH host-key verification is performed.
