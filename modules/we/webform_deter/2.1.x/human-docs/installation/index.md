# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module, version 6.2 or newer (`drupal/webform >=6.2`). Webform
  Deter attaches its behavior to Webform's submission forms, so this is a hard
  dependency — Composer will pull it in for you.

There are no other third‑party library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_deter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Webform) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_deter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_deter -y
```

Enabling Webform Deter also enables Webform if it is not already on.

Once enabled, nothing happens yet — the module ships with an empty pattern list.
Head to [Configuration](../configuration/index.md) to add the patterns that
should trigger a warning.
