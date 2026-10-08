# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **TMGMT** module (`drupal/tmgmt`, `^1.1`) — the module's Drupal dependency.
- The **`google/cloud-translate`** PHP library (`^1.13`), installed automatically as
  a Composer dependency. Because of this library, install the module **with
  Composer** rather than downloading the archive.
- Your site's **private file system** must be configured
  (`$settings['file_private_path']` in `settings.php`) — the Google credentials key
  is uploaded there.
- On the Google side: a **Google Cloud project** with the Cloud Translation API
  enabled, and a **service‑account JSON key** for it (see
  https://cloud.google.com/translate/docs/setup).
- At least two languages configured on your site.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_google_v3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update TMGMT,
the `google/cloud-translate` library, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_google_v3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_google_v3 -y
```

Enabling the module also enables TMGMT if it isn't already on. There's no settings
page — your next step is to create a Google V3 translation provider. See
[Configuration](../configuration/index.md).
