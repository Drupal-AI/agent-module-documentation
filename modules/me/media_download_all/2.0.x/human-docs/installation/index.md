# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a
  dependency.
- A configured **private file system**. The module stores its temporary `.zip`
  archives privately, so make sure your site has a private files path set up
  (the `file_private_path` setting in `settings.php`); otherwise the private
  storage it relies on is unavailable.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_download_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note:** the current 2.0.x release is an alpha (`2.0.0-alpha6`). If Composer
> declines to install it, check your project's `minimum-stability` setting or
> request the specific version explicitly.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_download_all -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_download_all -y
```

## Verify it worked

After enabling, go to an entity's **Manage display** and confirm the *download
all* formatter is available for a media reference field, or open **Block layout**
(`/admin/structure/block`) and confirm the *download all* block can be placed.
Then use the control on a page with attachments and check that you receive a
`.zip` containing the expected files — and that only files the current user may
access are included.
