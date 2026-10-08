# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **jQuery UI Droppable** — the drag‑and‑drop behavior relies on it. On modern
  Drupal this lives in the contributed *jQuery UI Droppable* module
  (`drupal/jquery_ui_droppable`); Composer will pull declared dependencies in for
  you, but if drag‑to‑move doesn't work, confirm that module is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/media_folder_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_folder_management -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_folder_management -y
```

## Set up permissions

This module ships a granular permission set, and nobody can use the explorer until
you grant at least the baseline permission. Go to **People → Permissions**
(`/admin/people/permissions`) and, for the roles that should manage media:

- Grant **access media folder file explorer** to anyone who needs the explorer.
- Grant the folder create/read/update/delete and own‑folder permissions as
  appropriate.
- Keep **bypass media folder files permissions** and any administer permissions to
  trusted administrators only.

## Verify it worked

Log in as a user who has the **access media folder file explorer** permission and
visit **`/admin/content/file-explorer`**. You should see the folder‑based file
manager, where you can create a folder and drag a file in to upload it.
