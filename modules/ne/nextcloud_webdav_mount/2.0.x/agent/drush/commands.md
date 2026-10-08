<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` (`NextcloudMountCommands`). All target a single user via `--uid=<id>`
or `--user=<name>` unless noted. Commands that spawn rclone abort with a message in **external** mode.

| Command | Alias | Purpose |
|---|---|---|
| `nextcloud_webdav_mount:config` | `nc-config` | Set global settings (below). Omitted options unchanged. |
| `nextcloud_webdav_mount:user-config` | `nc-user-config` | Set per-user credentials/mount options (merged, not replaced). |
| `nextcloud_webdav_mount:mount` | `nc-mount` | rclone FUSE mount for a user (mount mode). |
| `nextcloud_webdav_mount:unmount` | `nc-umount` | Unmount (fusermount3/fusermount, then umount). |
| `nextcloud_webdav_mount:sync` | `nc-sync` | rclone sync/bisync for one user (sync mode). |
| `nextcloud_webdav_mount:sync-all` | `nc-sync-all` | Sync every user with stored credentials. |
| `nextcloud_webdav_mount:status` | `nc-mount-status` | Show WebDAV URL, username, token-present, path, mounted?. In external mode shows external path + state. |
| `nextcloud_webdav_mount:check` | `nc-mount-check` | 7-step prerequisites check (config, credentials, rclone, FUSE, path, runtime dir, live `rclone lsd`). |

## `nc-config` options (writes `nextcloud_webdav_mount.settings`)

`--server-url`, `--webdav-path`, `--operation-mode` (`mount`|`sync`|`external`), `--external-mount-path`,
`--sync-direction` (`pull`|`push`|`bisync`), `--sync-interval` (seconds, 0 = off), `--remote-path`,
`--enable-log` (1/0 for the mount log). Invalid enum values error out without saving.

```bash
drush nc-config --server-url=https://cloud.example.com --webdav-path="/remote.php/dav/files/{username}/"
drush nc-config --operation-mode=sync --sync-direction=pull --sync-interval=3600
drush nc-config --operation-mode=external --external-mount-path=private://nextcloud
```

## `nc-user-config` options (writes `user.data`)

`--uid`/`--user` (required), `--username`, `--token`, `--mount-source` (`custom`|`imce`), `--role`
(IMCE role), `--filesystem` (`public`|`private`; sets both stream + IMCE scheme), `--folder` (IMCE folder,
e.g. `private://[user:name]`), `--mount-path` (custom stream/absolute path, Drupal tokens supported),
`--remote-path` (remote subpath). `--token` may not be empty; in external mode passing `--token` is
refused.

```bash
drush nc-user-config --uid=2 --username=alice --token=myapppassword
drush nc-user-config --user=alice --mount-path="private://users/alice" --filesystem=private --remote-path="Photos"
```

## Typical flows

```bash
# Sync (Docker / no FUSE)
drush nc-config --operation-mode=sync --server-url=https://cloud.example.com
drush nc-user-config --uid=2 --username=alice --token=xxx
drush nc-sync --uid=2          # or nc-sync-all

# Mount (bare metal / FUSE)
drush nc-config --server-url=https://cloud.example.com
drush nc-user-config --uid=2 --username=alice --token=xxx
drush nc-mount-check --uid=2   # fix anything flagged first
drush nc-mount --uid=2
drush nc-mount-status --uid=2
```

Notes: `nc-sync`/`nc-sync-all`/cron auto-recover from bisync "must run --resync" and exit-code-7
too-many-deletes safety aborts by clearing `.lst` files and retrying with `--resync`. `status`/`check`
print the token only as `*** set ***`, never in clear.
