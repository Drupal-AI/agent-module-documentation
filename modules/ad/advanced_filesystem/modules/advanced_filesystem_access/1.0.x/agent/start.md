<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# (ADFS) File Access Control (advanced_filesystem_access) — agent index

Submodule of **Advanced Filesystem**. Adds signed/expiring download URLs, per-file
download-count limits, IP allow/block lists and a per-download access log for `file` entities.

## What it is
- Depends on `drupal:file` and `advanced_filesystem:advanced_filesystem`.
- Config object `advanced_filesystem_access.settings` (signing_secret, token_ttl, global_ip_blocklist, log_retention_days).
- Two DB tables (`hook_schema` in `.install`): `adfs_access_log`, `adfs_access_config`.
- One restricted permission: `administer advanced_filesystem_access`.
- `configure` route: `advanced_filesystem_access.settings`.

## Routes (`advanced_filesystem_access.routing.yml`)
- `advanced_filesystem_access.settings` — `/admin/config/media/advanced_filesystem/access` (settings form; permission-gated).
- `advanced_filesystem_access.access_log` — `.../access/log` (log viewer form; permission-gated).
- `advanced_filesystem_access.download` — `/adfs/download/{fid}/{token}` — `_access: 'TRUE'`; the capability is the HMAC token, validated in the controller (see api doc).
- `advanced_filesystem_access.file_rules` — `/admin/content/files/{fid}/access-rules` (per-file rules form; permission-gated).

## Service & code
- `Service\FileAccessService` (`advanced_filesystem_access.file_access_service`) — `generateSignedUrl()`, `validateToken()` (HMAC-SHA256 + `hash_equals`), `isDownloadBlocked()`, `isIpAllowed()`, `logDownload()`, `getFileConfig()/setFileConfig()`, `pruneAccessLog()`.
- `Controller\SecureDownloadController::download()` — validates token → loads file → IP check → download-limit check → logs → `BinaryFileResponse` (attachment, no-cache).
- `TwigExtension\AdfsAccessTwigExtension` — `adfs_signed_url` filter + function (TTL int/seconds or shorthand `30m`/`2h`/`7d`/`1w`).
- `advanced_filesystem_access.module` — `hook_file_access()` forbids `download` when the per-file limit is reached.
- Forms: `AccessSettingsForm` (global), `FileAccessRulesForm` (per-file), `AccessLogForm` (log viewer).

## Solution docs
- Signed URLs & the download endpoint: [agent/api/signed-urls.md](api/signed-urls.md)
- Configuration, per-file rules, tables & permissions: [agent/config/settings.md](config/settings.md)
