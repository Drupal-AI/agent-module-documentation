# Installation

## Requirements

Acquia Connector needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The PHP **JSON extension** (`ext-json`), which is standard in modern PHP.
- No hard contrib module dependencies. On **Acquia hosting**, the **Key** module
  is used by an optional Key provider to fetch legacy network keys automatically;
  install it if you rely on that path.
- To actually connect, an **Acquia Cloud subscription** and its credentials (or an
  Acquia‑hosted environment where they are auto‑detected).

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_connector -y
```

Enabling the module does not connect anything on its own — you connect the site to
a subscription in [Configuration](../configuration/index.md).

## Submodules

Acquia Connector ships **no submodules**.

## Verify it worked

Go to **Configuration → Services → Acquia Connector**
(`/admin/config/services/acquia-connector`). You should see the connector settings
page, where you can start the connection. Continue to
[Configuration](../configuration/index.md) to connect the site.
