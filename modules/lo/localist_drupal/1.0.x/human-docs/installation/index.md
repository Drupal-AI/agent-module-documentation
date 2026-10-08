# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** and **Migrate** modules.
- Three contrib modules, pulled in as dependencies:
  - **Migrate Plus** (`migrate_plus`)
  - **Migrate Tools** (`migrate_tools`)
  - **Smart Date** (`smart_date`) — handles the event start/end times.
- Access to your organization's **Localist instance** and its API endpoint base
  URL (ask your Localist representative, or find it on your Localist home page).

## Install with Composer

From the project root:

```bash
composer require drupal/localist_drupal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus,
Migrate Tools, Smart Date, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localist_drupal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localist_drupal -y
```

Drupal will enable the Taxonomy, Migrate, Migrate Plus, Migrate Tools, and Smart
Date dependencies alongside it.

## Verify it worked

Log in as an administrator and visit **Configuration → Web services → Localist
settings** (`/admin/config/services/localist`). You should see the settings form,
including a **Preflight Check** section at the top. Continue to
[Configuration](../configuration/index.md) to connect to Localist and start
syncing.
