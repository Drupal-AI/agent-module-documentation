<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nextcloud WebDAV Mount brings a Nextcloud/WebDAV share into Drupal's private/public files via rclone, offering three operation modes — Mount (rclone FUSE), Sync (rclone sync/bisync, no FUSE), and External (a mount managed outside Drupal) — with IMCE integration, per-user credentials, cron sync and Drush commands.

---

Nextcloud WebDAV Mount integrates a Nextcloud (or generic WebDAV) share into Drupal's file system so IMCE and any module reading `private://`/`public://` can use the files. A global admin form picks the **operation mode**: **Mount** spawns `rclone mount` from PHP (needs FUSE + `/dev/fuse`, often `SYS_ADMIN`), **Sync** runs `rclone sync`/`bisync` on demand or on cron (no FUSE, Docker-safe), and **External** — new in 2.0 — is passive: something outside Drupal (host FUSE, sidecar, bind-mount) mounts Nextcloud onto `external_mount_path` (default `private://nextcloud`) and the module only reports status, storing no credentials and spawning no rclone. Server URL, WebDAV path template and cron interval are admin-only global settings; per-user forms hold each account's Nextcloud login name, app password/token, mount path source (IMCE profile or custom stream path) and remote subpath. rclone credentials are passed via `RCLONE_CONFIG_*` environment variables (obscured, never written to a config file — except a transient per-run file for bisync's stable-identity requirement). The WebDAV connection runs over the admin-configured HTTPS URL with normal TLS verification, both for Guzzle status checks (HEAD/PROPFIND) and for rclone. Optional OpenID Connect integration auto-fills a user's Nextcloud credentials from SSO claims on login. It provides its own permissions, config schema and eight Drush commands, in the Custom package.

Use it to make Nextcloud storage available inside Drupal. Several security points matter: **per-user Nextcloud credentials** are stored (in `user.data`) to authenticate to WebDAV — keep them secret (never plaintext in exported config or logs); choose the **destination scheme deliberately** — mounting/syncing into the **public** files directory would make the Nextcloud content web-accessible, so use the **private** file system for anything non-public and restrict download access; run rclone with least privilege; and operate WebDAV over HTTPS. IMCE integration exposes the files to the file browser (per permissions). Configure the mode, credentials and destination carefully.

---

- Mount a Nextcloud/WebDAV share into Drupal via rclone FUSE (mount mode).
- Sync a Nextcloud/WebDAV share into Drupal via rclone sync/bisync (no FUSE, Docker-safe).
- Track an externally managed mount (host FUSE, K8s/Docker sidecar, bind-mount) in External mode.
- Keep the PHP container unprivileged by choosing Sync or External over in-PHP FUSE.
- Choose sync direction: pull (Nextcloud → local), push (local → Nextcloud), or bisync (bidirectional).
- Run scheduled cron sync at a configurable interval for all users with stored credentials.
- Store per-user Nextcloud credentials (login name + app password/token).
- Auto-fill user credentials from OpenID Connect SSO claims on login.
- Integrate with IMCE so mounted/synced files appear in the file browser.
- Point a mount at a custom stream path (`private://users/alice`) with Drupal token support.
- Add a "Nextcloud" admin-toolbar tray with Global/User settings, IMCE, Local/Remote drive and Sync now.
- Set global server URL and WebDAV path template via the admin form or `nc-config` Drush.
- Migrate from Sync/bisync mode to an externally provided mount.
- Diagnose prerequisites (rclone, FUSE, paths, live WebDAV connection) with `nc-mount-check`.
- Trigger an immediate per-user sync from a toolbar link or `/user/nextcloud/sync`.
- Report mount/connection status on the per-user and admin status panels.
- Store the Nextcloud content in the private file system to keep it non-public.
- Provide its own permissions to gate admin vs own-credential configuration.
- Bulk-sync every configured user with a single Drush command or cron run.
- Recover automatically from bisync "must run --resync" and too-many-deletes safety aborts.
- Operate WebDAV over HTTPS with TLS verification for status checks and rclone transfers.
