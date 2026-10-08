# Configuration

Configuration is split between an **admin‑only global form** and a **per‑user
form**, and everything can also be driven from **Drush**. Make sure
`$settings['file_private_path']` is set in `settings.php` before you begin.

## Global settings (admin only)

Go to **Configuration → Web Services → Nextcloud WebDAV Mount**
(`/admin/config/services/nextcloud-webdav-mount`). This requires the **administer
nextcloud shared mounts** permission. The form shows all fields regardless of mode;
fields that don't apply to the active mode are visible but disabled, and submitting
only persists the active mode's values (so switching modes doesn't wipe another
mode's settings). The config object is `nextcloud_webdav_mount.settings`:

| Setting | Default | Meaning |
|---|---|---|
| **Server URL** (`server_url`) | *(empty)* | Base Nextcloud URL, e.g. `https://cloud.example.com`. |
| **WebDAV path** (`webdav_path`) | `/remote.php/dav/files/{username}/` | Path template; `{username}` is replaced per user. |
| **Operation mode** (`operation_mode`) | `mount` | `mount`, `sync`, or `external`. |
| **Sync direction** (`sync_direction`) | `pull` | `pull` (remote→local), `push` (local→remote), or `bisync` (bidirectional). Sync mode only. |
| **Sync interval** (`sync_interval`) | `0` | Cron sync interval in seconds; `0` disables cron sync. |
| **Sync / mount logs** (`enable_sync_log`, `enable_mount_log`) | `false` | Write rclone logs under `private://nextcloud_webdav_mount/rclone/`. |
| **External mount path** (`external_mount_path`) | `private://nextcloud` | Where an externally managed mount appears (External mode). |
| **Remote subpath** (`remote_path`) | `Documents` | Subdirectory within the Nextcloud WebDAV root to mount/sync. |

The admin status panel shows server reachability plus rclone/FUSE availability
(Mount/Sync), or the external path and mount state (External).

## Per‑user settings

Each user's credentials and mount path live at **`/user/{uid}/nextcloud`**
(route `nextcloud_webdav_mount.user_settings`). Access is granted to the account
owner with **configure own nextcloud credentials**, or to anyone with **administer
nextcloud user credentials** (who can edit any user's). Values are stored in
`user.data`:

- **Nextcloud login name** and **app password / token** (use a Nextcloud app
  password so it can be revoked independently).
- **Mount source** — a custom stream path or an **IMCE** profile (role → scheme →
  folder).
- **Mount path** — a `private`/`public` stream path (default `private`), optionally
  using Drupal tokens like `[user:name]`; blank defaults to
  `private://users/[user:name]`.
- **Remote subpath** — a per‑user override of the global remote subpath.

In **External** mode this form shows status only — no credentials, no
mount/unmount buttons.

## Activate

- On the per‑user form: **Mount / Unmount** (Mount mode) or **Sync now** (Sync
  mode). There is also a "Sync now" route at `/user/nextcloud/sync`.
- The admin toolbar adds a **Nextcloud** tray with Global/User settings, IMCE
  links, and Sync now (each link further gated by route access).

## Drush commands

Eight commands are provided (commands that spawn rclone abort in External mode):

| Command | Alias | Purpose |
|---|---|---|
| `nextcloud_webdav_mount:config` | `nc-config` | Set global settings. |
| `nextcloud_webdav_mount:user-config` | `nc-user-config` | Set per‑user credentials / mount options. |
| `nextcloud_webdav_mount:mount` | `nc-mount` | rclone FUSE mount for a user (Mount mode). |
| `nextcloud_webdav_mount:unmount` | `nc-umount` | Unmount. |
| `nextcloud_webdav_mount:sync` | `nc-sync` | rclone sync/bisync for one user (Sync mode). |
| `nextcloud_webdav_mount:sync-all` | `nc-sync-all` | Sync every user with stored credentials. |
| `nextcloud_webdav_mount:status` | `nc-mount-status` | Show WebDAV URL, username, token‑present, path, mounted?. |
| `nextcloud_webdav_mount:check` | `nc-mount-check` | Seven‑step prerequisites check (incl. a live `rclone lsd`). |

```bash
# Sync (Docker / no FUSE)
drush nc-config --operation-mode=sync --server-url=https://cloud.example.com --sync-direction=pull --sync-interval=3600
drush nc-user-config --uid=2 --username=alice --token=<app-password>
drush nc-sync --uid=2          # or nc-sync-all

# Mount (bare metal / FUSE)
drush nc-config --server-url=https://cloud.example.com
drush nc-user-config --uid=2 --username=alice --token=<app-password>
drush nc-mount-check --uid=2   # fix anything flagged first
drush nc-mount --uid=2

# External (mount managed outside Drupal)
drush nc-config --operation-mode=external --external-mount-path=private://nextcloud
```

`nc-sync`/`nc-sync-all`/cron auto‑recover from bisync "must run --resync" and
too‑many‑deletes safety aborts. Status/check output masks the token (shown only as
`*** set ***`), never in clear.

## Permissions

| Permission | Gates |
|---|---|
| **administer nextcloud shared mounts** | The global admin form and `nc-config` — so **only admins set the server URL**. |
| **configure own nextcloud credentials** | A user managing their **own** login/app password and using "Sync now". Unrestricted, because it only touches the user's own credentials. |
| **administer nextcloud user credentials** | Editing **any** user's Nextcloud credentials. |

## Path safety

Custom absolute mount paths are rejected unless they resolve inside the `private://`
or `public://` stream root, stream paths cannot escape their root via `..`, and a
`remote_path` containing `..` is rejected. This limits where a mount can point.

## OpenID Connect (optional)

If the OpenID Connect module is present, a post‑authorise hook can auto‑fill a
user's Nextcloud `username`/`token` from SSO userinfo claims
(`nextcloud_login_name`, `nextcloud_app_password`) on login. Failures are logged and
never break the login flow.

## Security checklist

- **Keep per‑user credentials secret** — stored in `user.data`, never displayed in
  clear. Prefer Nextcloud **app passwords**.
- **Choose the destination scheme deliberately** — syncing into **public** files
  makes content web‑accessible; use **private** and restrict download for
  non‑public content.
- WebDAV runs over the admin‑configured **HTTPS** URL with **TLS verification on**
  for both status checks and rclone. Keep it that way, and run rclone with least
  privilege.
- If you supply credentials for automation via environment variables, keep them out
  of version control — set them with `ddev dotenv set .ddev/.env --…` (never commit
  `.ddev/.env`) rather than hard‑coding any secret in the repository.
