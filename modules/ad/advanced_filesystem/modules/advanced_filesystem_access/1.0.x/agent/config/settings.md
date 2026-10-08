<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, per-file rules, tables & permissions

## Install / enable
`drush en advanced_filesystem_access` (pulls in `advanced_filesystem` and `file`). Then set a signing
secret before any signed URL will work.

## Global settings — `advanced_filesystem_access.settings`
Form `Form\AccessSettingsForm` at `/admin/config/media/advanced_filesystem/access`
(`administer advanced_filesystem_access`). Config keys (schema in `config/schema`):
- `signing_secret` (string, default `''`) — HMAC-SHA256 key. Empty = signed downloads disabled (validation fails closed). Changing it invalidates all outstanding links. Recommended ≥ 32 chars.
- `token_ttl` (int, default `3600`) — default signed-URL lifetime in seconds; form min 60; 0 = non-expiring.
- `global_ip_blocklist` (string, default `''`) — newline-separated IPs/CIDRs blocked from all signed downloads; `#` lines ignored; IPv4 CIDR supported.
- `log_retention_days` (int, default `90`) — access-log rows older than this are pruned on cron; a "Prune now" button calls `FileAccessService::pruneAccessLog()`.

## Per-file rules
Form `Form\FileAccessRulesForm` on local task `advanced_filesystem_access.file_rules`
`/admin/content/files/{fid}/access-rules`. Persists to `adfs_access_config` via
`FileAccessService::setFileConfig()`:
- `download_limit` (int, 0 = unlimited).
- `expires` (datetime → unix ts; 0 = never).
- `ip_allowlist` / `ip_blocklist` (newline-separated IPs/CIDRs).
The form also shows a download log for the file and a preview of the signed URL.
"Remove all rules for this file" calls `clearFileConfig()`.

## Log viewer
Form `Form\AccessLogForm` at route `advanced_filesystem_access.access_log`
`.../access/log` — reads `FileAccessService::getAccessLog()`.

## Database (`advanced_filesystem_access.install`, `hook_schema`)
- `adfs_access_log` — id, fid, uid, ip (45), timestamp, method (`direct`|`signed`), user_agent (512); indexes on fid/uid/timestamp. Dropped on uninstall.
- `adfs_access_config` — fid (PK), download_limit, ip_allowlist (text), ip_blocklist (text), expires. Dropped on uninstall.

## Enforcement outside the endpoint
`advanced_filesystem_access.module` implements `hook_file_access()`: on the `download` operation it
returns `AccessResult::forbidden()` when `FileAccessService::isDownloadBlocked()` is true, so the
per-file download-count limit also applies to ordinary core file downloads (not only the signed
endpoint). All other operations return neutral.

## Permission
`administer advanced_filesystem_access` (`restrict access: true`) gates the settings, log and
per-file-rules routes. The public download route carries no permission — access is the HMAC token.
