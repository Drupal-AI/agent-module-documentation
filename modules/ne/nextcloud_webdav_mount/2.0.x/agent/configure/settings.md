<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — global and per-user settings

## Global admin settings

- **Route:** `nextcloud_webdav_mount.settings` → `/admin/config/services/nextcloud-webdav-mount`
- **Permission:** `administer nextcloud shared mounts`
- **Config object:** `nextcloud_webdav_mount.settings`

Config keys (schema + install defaults):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `server_url` | string | `''` | Base Nextcloud URL, e.g. `https://cloud.example.com` (trailing slash trimmed). |
| `webdav_path` | string | `/remote.php/dav/files/{username}/` | WebDAV path template; `{username}` replaced per user. |
| `operation_mode` | string | `mount` | `mount`, `sync`, or `external`. |
| `sync_direction` | string | `pull` | `pull` (remote→local), `push` (local→remote), `bisync` (bidirectional; rclone ≥ 1.58). Sync mode only. |
| `sync_interval` | integer | `0` | Cron sync interval in seconds; `0` disables cron sync. |
| `enable_sync_log` | boolean | `false` | Write `private://nextcloud_webdav_mount/rclone/rclone-sync.log`. |
| `enable_mount_log` | boolean | `false` | Write `.../rclone-mount.log`. |
| `external_mount_path` | string | `private://nextcloud` | Where an externally managed mount appears (external mode). Stream wrapper or absolute path. |
| `remote_path` | string | `Documents` | Subdirectory within the Nextcloud WebDAV root to mount/sync (global default; per-user override). Set via Drush `--remote-path`. |

The form shows all fields regardless of mode; fields irrelevant to the active mode are visible but
disabled via Form API `#states` (requires `core/drupal.states`). Submit only persists values for the
active mode, so switching modes does not wipe another mode's settings. The admin status panel shows
server reachability + rclone/FUSE availability (mount/sync) or external path + mount state (external).

## Per-user settings

- **Route:** `nextcloud_webdav_mount.user_settings` → `/user/{user}/nextcloud` (`user` = numeric uid)
- **Access:** account owner with `configure own nextcloud credentials`, OR any user with
  `administer nextcloud user credentials` (custom access check).
- **Storage:** `user.data`, module `nextcloud_webdav_mount`, name `settings` (an array).

Per-user keys: `username` (Nextcloud login), `token` (app password), `mount_source`
(`custom`|`imce`), `imce_role` / `imce_scheme` / `imce_folder` (IMCE profile selection), `mount_path_stream`
(`private`|`public`, default `private`), `mount_path` (custom stream/absolute path; supports Drupal
tokens like `[user:name]`; blank ⇒ default `private://users/[user:name]`), `remote_path` (per-user
override of the global remote subpath).

In **external** mode the per-user form shows status only — no credentials, no mount/unmount buttons.
Otherwise action buttons depend on mode: Mount/Unmount (mount) or Sync now (sync).

## Path safety

- Custom absolute mount paths are rejected unless they resolve inside the `private://` or `public://`
  stream root (`isPathWithinStreamRoot`); stream paths cannot escape their root via `..`
  (`resolveStreamPath` normalizes traversal).
- `remote_path` containing `..` is rejected (returns empty/root).

## IMCE integration

If IMCE is enabled, the mount path can be sourced from an IMCE profile (role → scheme public/private →
folder). The toolbar tray adds "Shared folder in IMCE" and "Local drive" (opens `imce.page` for the
user's mount scheme) when the user may access those routes.

## OpenID Connect (optional)

`hook_openid_connect_post_authorize` fills a user's `username`/`token` from SSO userinfo claims
(`nextcloud_login_name`, `nextcloud_app_password`) on login, via `OpenIdConnectSsoService`. Failures are
logged and never break the login flow.
