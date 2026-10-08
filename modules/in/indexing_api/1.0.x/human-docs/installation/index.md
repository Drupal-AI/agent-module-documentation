# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **private file system** configured on your site — the Google service-account
  key is uploaded and stored under `private://indexing-api/`, so file uploads to
  a private stream must work before you can save the key.
- On the Google side (needed before the module can do anything useful): a Google
  Cloud project with the **Indexing API** enabled, a **service account** added as
  an *owner* of your property in Google Search Console, and that service
  account's **JSON key file**. See [Configuration](../configuration/index.md).

There are no third‑party Composer or PHP library requirements for the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/indexing_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/indexing_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en indexing_api -y
```

## Verify it worked

Log in as user 1 (or a user granted the module's admin permission — see the note
in [Configuration](../configuration/index.md)) and go to **Configuration → Web
services → Indexing API** (`/admin/config/services/indexing-api`). If the
settings form loads, the module is installed. Nothing is sent to Google until you
upload a service-account key and assign at least one bundle.
