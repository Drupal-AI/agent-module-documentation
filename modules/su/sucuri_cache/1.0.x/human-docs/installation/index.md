# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Sucuri Website Firewall** account with **API access enabled** — you will need
  your Sucuri API endpoint, API key, and API secret to configure the module.
- No module dependencies, and no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sucuri_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sucuri_cache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sucuri_cache -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Web services → Sucuri Cache**
(`/admin/config/services/sucuri_cache`). You should reach the settings form, where
you enter your Sucuri API credentials. Continue with
[Configuration](../configuration/index.md).
