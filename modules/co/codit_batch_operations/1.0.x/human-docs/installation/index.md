# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed modules or external libraries are required.
- A local/custom module where your batch-operation scripts will live (you create
  a `src/cbo_scripts/` directory in it — see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/codit_batch_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/codit_batch_operations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en codit_batch_operations -y
```

## Submodule — the optional UI

The base module lets you run operations from code and Drush. To run them from the
admin UI and view their logs there, also enable the **Codit: Batch Operations
UI** submodule. Enable it from the **Extend** page (`/admin/modules`), or with
Drush:

```bash
drush en codit_batch_operations_ui -y
```

You do not need the UI submodule if you only run operations from
`hook_update_N()`, deploy hooks, cron, or the Drush command.

## Verify it worked

Log in as an administrator and open
`/admin/config/development/batch_operations/settings`. If the settings form
loads, the module is installed. With the UI submodule enabled, the operations
listing lives at `/admin/config/development/batch_operations`. Next, follow
[Configuration](../configuration/index.md) to point the module at your scripts.
