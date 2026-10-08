# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **JS Cookie** module (`js_cookie`), which provides the JavaScript cookie
  library the pop‑up uses to remember that a visitor dismissed the banner.
  Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gdpr_compliance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required JS
Cookie module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gdpr_compliance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gdpr_compliance -y
```

This also enables JS Cookie if it isn't already on. After enabling, configure the
banner and the consent checkbox from the **GDPR** settings forms — see
[Configuration](../configuration/index.md).

## Submodules

GDPR Compliance ships no submodules.
