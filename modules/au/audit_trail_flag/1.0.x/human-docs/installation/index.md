# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Admin Audit Trail** (`admin_audit_trail`) module — this is where
  the log entries are written.
- The contrib **Flag** (`flag`) module — the source of the flag/unflag events.

Composer pulls both dependencies in with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/audit_trail_flag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Admin Audit Trail
and Flag and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit_trail_flag -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audit_trail_flag -y
```

Drupal enables the Admin Audit Trail and Flag dependencies at the same time. There
is no configuration step — flag and unflag operations are logged automatically
from then on. See [How to use it](../index.md#how-to-use-it).
