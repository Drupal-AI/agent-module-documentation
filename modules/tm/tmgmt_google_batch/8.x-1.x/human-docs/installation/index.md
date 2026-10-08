# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Translation Management Tool** module (`tmgmt`) — the framework this
  provider plugs into.
- A **Google Cloud Platform** account with an application that has the **Google
  Cloud Translation API** enabled, and an **API key** for it.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_google_batch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_google_batch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_google_batch -y
```

TMGMT is enabled automatically as a dependency if it is not already on.

## Verify it worked

Go to **Configuration → Regional and language → Translation providers**
(`/admin/tmgmt/translators`) and add a provider — the Google batch translator
should be selectable. Then continue to [Configuration](../configuration/index.md)
to enter your API key.
