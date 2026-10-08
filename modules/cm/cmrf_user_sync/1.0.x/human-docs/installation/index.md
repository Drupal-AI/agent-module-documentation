# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **CMRF Core** (`cmrf_core`) — provides the CiviMRF connection to CiviCRM. This
  is the only Drupal module dependency.
- A **CiviCRM** backend reachable over a configured CiviMRF connection, with the
  **ChangeMessages extension** installed and a change-message definition to
  consume.
- A working Drupal **cron** — the sync processes its queue on cron runs.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_user_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CMRF Core and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cmrf_user_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmrf_user_sync -y
```

## Verify it worked

Log in as an administrator and open
`/admin/config/cmrf_user_sync/usersyncconfig`. If the configuration form loads,
the module is installed. Nothing syncs until you configure a connection, message
definition, and processor, then tick **Enabled** — see
[Configuration](../configuration/index.md).
