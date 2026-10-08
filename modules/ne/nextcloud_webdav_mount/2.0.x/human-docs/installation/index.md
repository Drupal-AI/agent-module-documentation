# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **rclone** on the system `PATH` — required for **Mount** and **Sync** modes
  (`apt install rclone`, `pacman -S rclone`, etc.). Not needed for External mode.
  For bisync, rclone ≥ 1.58 is required.
- **FUSE** (`fuse3` + `/dev/fuse`) — required only for **Mount** mode when rclone
  runs inside PHP. **Sync** needs neither; **External** relies on a mount created
  outside Drupal.
- **Drupal private files** configured — set `$settings['file_private_path']` in
  `settings.php`.
- Optional: **IMCE** (profile folder as target + file browser), and the **OpenID
  Connect** module if you want SSO‑driven credential auto‑fill.

No Composer package dependencies and no third‑party PHP libraries are required.

> **Docker / Kubernetes:** keep the PHP container unprivileged by choosing **Sync**
> or **External** mode — **Mount** needs `/dev/fuse` access (often `SYS_ADMIN`),
> which default systemd/Docker settings usually block. See the module's
> `FUSE_SETUP.md` if you do run Mount inside PHP.

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
WebDAV Mount** (`/admin/config/services/nextcloud-webdav-mount`). The global form
should load with its status panel. You can also run the built‑in prerequisites
check from the CLI:

```bash
drush nc-mount-check --uid=<a-user-id>
```

It runs a seven‑step check (config, credentials, rclone, FUSE, path, runtime dir,
and a live `rclone lsd`). Fix anything it flags, then continue with
[Configuration](../configuration/index.md).
