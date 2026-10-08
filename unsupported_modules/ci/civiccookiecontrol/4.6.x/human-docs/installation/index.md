# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0** or newer (the module declares a PHP 8.0 requirement).
- A **Civic Cookie Control account and API key / licence**. The consent widget is
  Civic's hosted product, so the banner won't function without a key from Civic —
  sign up for one before you configure the module.

There are no other contributed‑module dependencies.

## Install with Composer

Note the naming: the **project** on drupal.org is `civicccookiecontrol` (triple
"c"), so that's the Composer package, even though the module you enable is
`civiccookiecontrol`.

```bash
composer require drupal/civicccookiecontrol -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civicccookiecontrol -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `civiccookiecontrol` (single, then double "c"):

```bash
drush en civiccookiecontrol -y
```

The module ships no submodules. Once enabled, add your Civic API key and configure
categories on the admin screens — see [Configuration](../configuration/index.md).
