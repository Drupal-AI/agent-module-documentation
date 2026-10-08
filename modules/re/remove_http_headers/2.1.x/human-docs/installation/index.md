# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other dependencies — the module needs only Drupal core.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_http_headers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_http_headers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_http_headers -y
```

As soon as it is enabled, the three default headers (`X-Generator`,
`X-Drupal-Dynamic-Cache`, `X-Drupal-Cache`) are stripped from responses. To
change the list, open **Configuration → System → Remove HTTP headers settings** —
see [Configuration](../configuration/index.md).
