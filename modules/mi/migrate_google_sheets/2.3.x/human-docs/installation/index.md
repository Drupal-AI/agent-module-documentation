# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Migrate Plus](https://www.drupal.org/project/migrate_plus)** module
  (`drupal/migrate_plus >= 6.0.6`) — Composer pulls this in for you. It in turn
  builds on core's Migrate module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_google_sheets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_google_sheets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_google_sheets -y
```

## Submodules — optional example

The project ships an example you can enable to see a full, runnable migration:

| Submodule | Machine name | What it provides |
|---|---|---|
| **Migrate Google Sheets Example** | `migrate_google_sheets_example` | A working example migration you can copy as a template. |
| **…Example Setup** | `migrate_google_sheets_example_setup` | A nested helper that sets up the fixtures the example uses. |

The example depends on Migrate Tools and Redirect, so install those first if you want
to run it. For a real project you don't need the example — enable just the base
module and write your own migration.

Next, store your Google API key and reference the parser in a migration — see
[Configuration](../configuration/index.md).
