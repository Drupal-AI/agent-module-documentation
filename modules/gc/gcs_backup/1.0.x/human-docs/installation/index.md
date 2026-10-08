# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Google Cloud PHP client library**, pulled in by Composer when you install
  the module.
- A **Google Cloud Platform** account with Storage access and a bucket for your
  backups.
- A configured **private filesystem** in Drupal (backups are staged in
  `private://gcs_backups/`).

## Install with Composer

From the project root:

```bash
composer require drupal/gcs_backup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Google Cloud
client library and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gcs_backup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gcs_backup -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → GCS Backup**
(`/admin/config/system/gcs-backup`). If the settings form loads, continue to
[Configuration](../configuration/index.md). You can also confirm the module's
Drush commands are available by running `drush list` and looking for the backup
commands.
