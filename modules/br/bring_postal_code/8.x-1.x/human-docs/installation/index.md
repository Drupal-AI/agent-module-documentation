# Installation

## Requirements

- **Drupal 8.7.7 or newer, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- No other module dependencies and no third‑party PHP libraries.
- Access to a **Bring postcode client URL** — the endpoint the browser calls for
  lookups (you set this on the settings form). Because the request is made
  client‑side, no server‑side proxy or API key is stored in Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/bring_postal_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bring_postal_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bring_postal_code -y
```

Nothing happens visibly until you configure which forms and fields to attach the
lookup to — see [Configuration](../configuration/index.md).
