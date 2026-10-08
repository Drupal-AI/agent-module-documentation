# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) — the only dependency,
  enabled automatically.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_backup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_backup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_backup -y
```

After enabling, set the backup directory in `settings.php` and review the module's
permission under **People → Permissions** — grant **Backup configuration** only to
trusted administrators, since backups can contain sensitive values. See
[Configuration](../configuration/index.md) for the `$settings['config_backup_directory']`
setting you must add before backups will work.

## Verify it worked

Once the backup directory is configured, open the Backup page (see
[Configuration](../configuration/index.md)) and create a test backup, or run
`drush config:backup`. Confirm a `configs-<date>_<time>.tar.gz` snapshot appears in
your configured directory.

> **Tip:** The module ships a `README.md` with the most complete, up-to-date
> documentation — worth a look for any additional details.
