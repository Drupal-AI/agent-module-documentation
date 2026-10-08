# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **rclone** on the system `PATH` — required for **Mount** and **Sync** modes
  (`apt install rclone`, `pacman -S rclone`, etc.). Not needed for External mode.
- **FUSE** (`fuse3` + `/dev/fuse`) — required only for **Mount** mode when rclone
  runs inside PHP. **Sync** needs neither FUSE nor `/dev/fuse`; **External** relies
  on a mount created outside Drupal.
- **Drupal private files** configured — set `$settings['file_private_path']` in
  `settings.php` so files can live in the private file system.
- Optional: the **IMCE** module, if you want an IMCE profile folder as the
  mount/sync target and a file browser for the local path.

No Composer package dependencies and no third‑party PHP libraries are required.

> **Docker / Kubernetes:** if the PHP container must stay unprivileged, prefer
> **Sync** or **External** mode — **Mount** mode requires `/dev/fuse` access, which
> default systemd/Docker settings often block.

## Install with Composer

From the project root:

```bash
composer require drupal/nextcloud_webdav_mount -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nextcloud_webdav_mount -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nextcloud_webdav_mount -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web Services → Nextcloud
WebDAV Mount** (`/admin/config/services/nextcloud-webdav-mount`). The global
settings form should load and its status panel should report whether rclone (and,
for Mount mode, FUSE) is available. Continue with
[Configuration](../configuration/index.md) to choose a mode and connect.
