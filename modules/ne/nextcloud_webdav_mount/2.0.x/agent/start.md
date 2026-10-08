<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nextcloud WebDAV Mount — agent index

Brings a **Nextcloud/WebDAV share into Drupal's files** via rclone. Version **2.0.0**, core `^10 || ^11`.
No Composer/module dependencies; needs the `rclone` binary on `PATH` for mount/sync (not for external).

Three **operation modes** (global `operation_mode` config):
- **mount** — PHP spawns `rclone mount` (FUSE + `/dev/fuse`, often `SYS_ADMIN`).
- **sync** — PHP runs `rclone sync`/`bisync` on demand or on cron (no FUSE; Docker-safe).
- **external** *(new in 2.0)* — passive: an out-of-band mount (host/sidecar/bind-mount) appears at
  `external_mount_path` (default `private://nextcloud`); module only reports status, stores no
  credentials, spawns no rclone.

Global settings (server URL, WebDAV path, mode, cron) are admin-only; per-user settings (login name,
app password/token, mount path, remote subpath) live at `/user/{uid}/nextcloud`. IMCE integration and an
admin-toolbar tray are included. Optional OpenID Connect auto-fills credentials from SSO claims.

**Capabilities:**
- [Configure global + per-user settings](configure/settings.md) — admin form, config keys, IMCE, modes.
- [Drush commands](drush/commands.md) — config, per-user config, mount/unmount, sync, status, check.
- [Permissions](permissions/permissions.md) — what gates admin vs own-credential access.

**Security:** WebDAV runs over the admin-configured HTTPS URL with **TLS verification on** — both Guzzle
status checks (HEAD/PROPFIND, Drupal `http_client`) and rclone use default cert validation; no
`verify=>false` / `--no-check-certificate`. rclone credentials are passed via obscured `RCLONE_CONFIG_*`
env vars, not a config file (bisync writes a transient per-run file, deleted after). Only admins set the
server URL (no lower-priv SSRF). Store **per-user Nextcloud credentials** securely (never plaintext);
choose the destination scheme deliberately — syncing into **public** files makes content web-accessible,
so use **private** + restrict download for non-public content; rclone least privilege.
