<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `nextcloud_webdav_mount.permissions.yml`.

| Permission | Restricted | Gates |
|---|---|---|
| `administer nextcloud shared mounts` | yes | Global admin form `/admin/config/services/nextcloud-webdav-mount` (server URL, mode, cron, logs). Also shows the toolbar "Global settings" link. |
| `configure own nextcloud credentials` | no | Set one's **own** Nextcloud login name + app password / mount options at `/user/{own-uid}/nextcloud`; use the `/user/nextcloud/sync` "Sync now" route. |
| `administer nextcloud user credentials` | yes | Edit Nextcloud credentials for **any** user (access to any `/user/{uid}/nextcloud`). |

## Access logic

- `/user/{user}/nextcloud` (`UserSettingsAccessCheck`): allowed if the account has
  `administer nextcloud user credentials`, OR the account is viewing **its own** profile and has
  `configure own nextcloud credentials`. Otherwise forbidden. Cached per user + per permissions.
- `/user/nextcloud/sync` (Sync now): requires `configure own nextcloud credentials`; operates on the
  current user only.
- Admin form + Drush `nc-config`: gated by `administer nextcloud shared mounts` — so **only admins set
  the server URL** (no lower-privilege server-URL / SSRF surface).
- Toolbar item shows for logged-in users with `configure own nextcloud credentials` OR
  `administer nextcloud shared mounts`; individual tray links are further gated by route access.

Notes: `configure own nextcloud credentials` is intentionally unrestricted — it only lets a user manage
their **own** credentials, which are stored in `user.data` and never displayed in clear (status output
masks the token). Cross-user credential editing needs the restricted
`administer nextcloud user credentials`.
