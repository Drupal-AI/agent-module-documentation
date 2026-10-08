# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3||^11||^12`).
- Core modules **Node** (`node`), **Field** (`field`), and **File** (`file`) —
  enabled in a standard install.
- A **private file system** configured in `settings.php`, with the file fields you
  want to track set to the **Private files** upload destination. Public files
  cannot be counted — see below.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/download_statistics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/download_statistics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en download_statistics -y
```

## The private‑files prerequisite

Counting only works for files stored in a **private** directory. Public files are
sent directly to the browser by the web server, bypassing Drupal, so there is no
way to record the download. In each relevant file field's **Field settings**, set
**Upload destination: Private files**, and make sure a private directory is
configured in `settings.php`.

## Verify it worked

Set a file field to the private scheme, attach a file, and download it. Then visit
the settings page (`/admin/config/system/download-statistics`) and/or the
"Popular file downloads" block once placed, and confirm the download was recorded.
If counts stay at zero, re‑check the private‑files configuration.
