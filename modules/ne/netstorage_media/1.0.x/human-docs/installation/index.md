# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal enables it automatically as a
  dependency.
- The **`nkmani/netstorage-cms-api`** PHP library, which Composer installs
  alongside the module.
- **Akamai NetStorage** access and its credentials (see
  [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/netstorage_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in the `nkmani/netstorage-cms-api` library the module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/netstorage_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en netstorage_media -y
```

## Recommended: the Key module

The NetStorage API key should be stored securely with the **Key** module. If it is
not already present:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

## Verify it worked

Visit **Configuration → Media → NetStorage Media**
(`/admin/config/media/netstorage-media`). If the settings form loads, the module and
its library are installed. Continue to [Configuration](../configuration/index.md) to
enter credentials, add a NetStorage media type, and set up sync.
