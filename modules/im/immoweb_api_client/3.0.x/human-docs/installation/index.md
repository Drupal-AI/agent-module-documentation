# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Immoweb API credentials for your project** — you must request these from the
  Immoweb team at `api@immoweb.be` before the client can authenticate. Version
  3.0.x targets version 3 of the Immoweb API.

There are no other module dependencies and no third‑party Composer or PHP library
requirements listed.

## Install with Composer

From the project root:

```bash
composer require drupal/immoweb_api_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/immoweb_api_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en immoweb_api_client -y
```

## Verify it worked

Open the module's configuration form (see [Configuration](../configuration/index.md)),
enter your Immoweb credentials, and save. Since the module is a developer library
with no front‑end feature of its own, the real confirmation is a successful
authenticated call to the classified pipeline from your custom code.
