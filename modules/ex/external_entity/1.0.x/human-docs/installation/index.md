# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.3**.
- A remote Drupal site running the **External Entity Server** module, with at least
  one resource configured and exposed — this Consumer module fetches from it.

There are no additional Composer or PHP library requirements.

> **Note on security coverage:** this project is **not covered by Drupal's security
> advisory policy**. Also note this is a release candidate (`1.0.0-rc1`) — test
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/external_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_entity -y
```

## Storing connection credentials safely

If the remote server requires authentication, **do not hard-code or commit the
secret**. Store it as an environment variable and reference it through the **Key**
module, or via DDEV's dotenv support, so it stays out of exported configuration.

## Verify it worked

Go to **Configuration → Web services → External Entity → Connection**
(`/admin/config/services/external-entity/connection`) and confirm you can add a
connection. This is the first step of the setup described in
[Configuration](../configuration/index.md).

Next, see [Configuration](../configuration/index.md) to add a connection and define
external entity types.
