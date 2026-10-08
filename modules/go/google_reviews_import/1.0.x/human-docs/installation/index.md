# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Migrate Tools** (`migrate_tools`) and **Migrate Plus** (`migrate_plus`) — the
  import runs on the Migrate framework.
- The **Key** module (`key`) — stores your Google API credentials securely.
- A **Google** account/API key with access to the reviews of the business
  locations you own (see [Configuration](../configuration/index.md)).

Drupal enables the module dependencies automatically when you install this module.

## Install with Composer

From the project root:

```bash
composer require drupal/google_reviews_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_reviews_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_reviews_import -y
```

This also enables Migrate Tools, Migrate Plus and Key if they are not already on.

## Verify it worked

Go to **Configuration → Web services → Google Reviews Import**
(`/admin/config/services/google_reviews_import_settings`). If the settings form
loads, the module is installed — next, add your API key and run the import as
described in [Configuration](../configuration/index.md).
