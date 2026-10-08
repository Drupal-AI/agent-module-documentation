# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/noscript_tag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/noscript_tag -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noscript_tag -y
```

## Verify it worked

Go to **Configuration → Development → Noscript Tag**
(`/admin/config/development/noscript-tag-setting`). If the settings form loads, the
module is active. Nothing is shown to visitors until you enter a message and grant
the *view noscript tag* permission — continue to
[Configuration](../configuration/index.md).
