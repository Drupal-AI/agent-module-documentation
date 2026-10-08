# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Google API PHP client** library. If you install this module with Composer
  the library comes along automatically; if you do not use Composer you must add
  it yourself with `composer require google/apiclient:^2.0`.
- Drupal's **private file system** must be enabled (the uploaded service‑account
  key is stored there).
- A **Google Cloud project** with the Sheets API enabled and a **service account**
  with a JSON key.

## Install with Composer

From the project root:

```bash
composer require drupal/spreadsheets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Google API
client and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spreadsheets -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spreadsheets -y
```

## Enable the private file system

Make sure a **private file system path** is configured (at **Configuration →
Media → File system**), because the module stores your uploaded Google service‑
account key there.

## Verify it worked

After configuring credentials and a sheet (see
[Configuration](../configuration/index.md)), you can retrieve the data in code
with:

```php
\Drupal::service('spreadsheets_sheets.base')->getData();
```

A successful call returns the rows from your configured Google Sheet.
