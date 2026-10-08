# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **cron** setup — the module relies on `hook_cron` to open and close
  windows, so nothing happens automatically unless cron runs.
- **Optional:** the [Read Only Mode](https://www.drupal.org/project/read_only_mode)
  module, if you want windows to switch the site into read-only mode instead of
  full maintenance mode.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_windows -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/maintenance_windows -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_windows -y
```

## Verify it worked

Log in as a user with the **Administer maintenance_window configuration**
permission and go to **Configuration → Development → Maintenance Windows**
(`/admin/config/development/maintenance-windows`). You should see the scheduling
interface, ready for you to add your first window. From here, continue to
[Configuration](../configuration/index.md).
