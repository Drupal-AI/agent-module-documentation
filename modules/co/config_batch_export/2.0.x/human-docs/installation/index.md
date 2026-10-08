# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Configuration** (`config`), **File** (`file`), and **Datetime**
  (`datetime`) modules — all part of Drupal core and enabled automatically as
  dependencies.
- A **configured private filesystem**. The generated archive is written to the
  private files directory, so this must be set up before you export. Create a
  folder outside your web root and point Drupal at it in `settings.php`:

  ```php
  $settings['file_private_path'] = '../path_to_private_folder';
  ```

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_batch_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_batch_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_batch_export -y
```

## Verify it worked

Go to **Configuration → Development → Configuration synchronization → Export →
Full archive** (`/admin/config/development/configuration/full/export`). Alongside
the standard export controls you should now see an **Export in batch** button.
Click it, let the batch run, and confirm a download link appears in the status
message.
