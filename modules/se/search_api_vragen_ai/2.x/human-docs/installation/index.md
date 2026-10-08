# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Search API** module (`search_api`).
- Access to a **Vragen.ai environment**, including an API endpoint created for
  your organisation and a bearer token.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_vragen_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_vragen_ai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_vragen_ai -y
```

## Verify it worked

After enabling, go to **Configuration → Search and metadata** — you should see a
**Vragen.ai** entry for entering your endpoint and token. The module is installed
but not yet functional: follow [Configuration](../configuration/index.md) to
authenticate and connect a Search API server and index.
