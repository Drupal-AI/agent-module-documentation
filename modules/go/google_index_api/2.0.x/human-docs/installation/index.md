# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Google API PHP client** library (`google/apiclient ^2.0`), pulled in as a
  Composer requirement.
- A Google Cloud project with a **service account** and a downloaded JSON key, with
  access to the **Indexing API** — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/google_index_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer also install the required
`google/apiclient` library alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_index_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_index_api -y
```

## Verify it worked

Go to **Configuration → Web services → Google Index API**
(`/admin/config/services/google-index-api`) — the settings form should load with
setup instructions. This configuration uses site *state*, so you will need to set it
up once on each environment where you install the module. Continue to
[Configuration](../configuration/index.md).
