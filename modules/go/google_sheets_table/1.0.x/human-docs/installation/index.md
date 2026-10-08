# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Key** module (`key`) — a hard dependency, used to hold the service-account
  credentials JSON. Drupal enables it as a dependency.
- A **Google Cloud service account** with the Sheets and Drive APIs enabled, and
  its credentials JSON downloaded (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/google_sheets_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_sheets_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_sheets_table -y
```

This also enables the Key module if it is not already on.

## Verify it worked

Go to **Configuration → Web services → Google Sheets Table**
(`/admin/config/services/google-sheets-table`). If the settings form loads, the
module is installed — next, set up the service account and Key as described in
[Configuration](../configuration/index.md).
