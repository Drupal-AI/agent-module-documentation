# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core modules **Field** (`field`) and **File** (`file`) — enabled in a standard
  install.
- Your site must have a **private file system** configured (a private files path
  in `settings.php`), and the file fields you want to track must use the
  **private** upload destination. Public files cannot be counted — see below.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/download_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/download_count -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en download_count -y
```

## The private‑files prerequisite

This is the one thing that most often trips people up: **only downloads of files
in *private* file fields are counted.** Public files are served directly by the web
server, bypassing Drupal entirely, so there is no opportunity to count them. Make
sure a private file system is configured and that each file field you want to track
is set to the **Private files** upload destination in its field settings.

## Verify it worked

Set a file field to the private scheme, attach a file to a node, and download it as
a non‑admin user (remember downloads by user 1 are never counted). Then open
**Reports → Download count** (`/admin/reports/download-count`) and confirm the
download was recorded. If the count stays at zero, re‑check that the field really
uses the private file system.
