# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A Google Cloud **service account** with permissions for the Google Cloud APIs the
  consuming modules will use, and its downloaded **JSON** key.

There are no additional Composer library or PHP requirements for the base module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/google_credentials -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_credentials -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_credentials -y
```

## Verify it worked

Go to **Configuration → Google → Google Cloud Credentials** — the credentials form
should load, ready for you to upload the service‑account JSON. Then follow
[Configuration](../configuration/index.md).
