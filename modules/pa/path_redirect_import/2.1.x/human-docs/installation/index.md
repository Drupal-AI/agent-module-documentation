# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`) and **PHP 7.1 or
  newer**.
- Three contributed modules, all installed automatically by Composer as
  dependencies:
  - **Redirect** (`drupal/redirect`, `>=1.7`) — provides the redirect entities this
    module creates and the admin listing the tabs attach to.
  - **Migrate Source CSV** (`drupal/migrate_source_csv`, `^3.5`) — reads the CSV.
  - **Migrate Tools** (`drupal/migrate_tools`, `^6.1.0`) — runs the import batch and
    backs the Drush commands.
- Core's **Migrate** module is also used and will be enabled as part of the
  dependency chain.

## Install with Composer

From the project root:

```bash
composer require drupal/path_redirect_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Redirect, Migrate
Source CSV, and Migrate Tools and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/path_redirect_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_redirect_import -y
```

Its dependencies (Redirect, Migrate Source CSV, Migrate Tools, and Migrate) are
enabled at the same time. There are no sub‑modules.

## Verify it worked

Log in as a user with the **Administer redirects** permission and go to
**Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`). You should now see **Migrate** and **Export**
tabs on that page. See [Configuration](../configuration/index.md) for the CSV format
and how to run an import.
