# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- A working **cron** run — the scheduled cleanup is triggered by cron.

There are no third‑party Composer or PHP library requirements, and no module
dependencies. The current release is an **alpha** (`3.0.0-alpha1`), so test it away
from production first.

## Install with Composer

From the project root:

```bash
composer require drupal/cleaner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cleaner -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cleaner -y
```

## Verify it worked

Go to **Configuration → System → Cleaner** (`/admin/config/system/cleaner`). You
should reach the Cleaner settings form. Choose what should run and how often (see
[Configuration](../configuration/index.md)), save, and the tasks will then be
carried out on cron.
