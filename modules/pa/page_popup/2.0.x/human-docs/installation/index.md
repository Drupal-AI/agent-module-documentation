# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No contributed module dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/page_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_popup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_popup -y
```

Enabling the module creates its admin configuration page at
**Configuration → System → Page popup** (`/admin/config/system/page_popup`).

## Verify it worked

Open **Configuration → System → Page popup**, add a popup message, target it at a
page, and then visit that page as a visitor — the popup should appear after the
configured delay. See [Configuration](../configuration/index.md) for the details.
