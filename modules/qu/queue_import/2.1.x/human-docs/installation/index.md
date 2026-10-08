# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) and **Media** (`media`) modules — both are enabled
  automatically as dependencies.
- **Drush**, since the import workflow is driven almost entirely by Drush commands.
- For the legacy‑import workflow, access to a **Drupal 7 database** you can connect
  to from your Drupal site.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_import -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_import -y
```

## Verify it worked

Confirm the example import works end to end:

```bash
drush itest
drush queue-run node_queue_processor -v
```

Then check **Content** (`/admin/content`) — you should see the single example
article the command imported. Once that works, move on to the Drupal 7 workflow: set
up the database connection on the [Configuration](../configuration/index.md) form
and follow the "How to use it" steps in the [overview](../index.md).
