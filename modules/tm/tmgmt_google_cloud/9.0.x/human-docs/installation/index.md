# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7||^9||^10||^11`).
- The **Translation Management Tool** module (`tmgmt`). Although the packaged
  metadata does not list it as a hard dependency, the module is a TMGMT translator
  plugin and needs TMGMT installed and enabled to do anything — install it
  alongside this module.
- A **Google account** and **Google Cloud credentials / API key** with the Cloud
  Translation service enabled.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_google_cloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_google_cloud -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_google_cloud -y
```

If TMGMT is not already enabled, enable it too:

```bash
drush en tmgmt tmgmt_google_cloud -y
```

## Verify it worked

Go to **Configuration → Regional and language → Translation providers**
(`/admin/tmgmt/translators`) and add a provider — the Google Cloud translator
should be selectable. Then continue to [Configuration](../configuration/index.md).
