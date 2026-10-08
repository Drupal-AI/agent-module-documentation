# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install.
- A **Mapy.com API key** — the maps use the Mapy.com REST API, so you will need a
  key from Mapy.com to display maps. See [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/mapycom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mapycom -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapycom -y
```

## Verify it worked

At **Extend** (`/admin/modules`) confirm **Mapy.com** is checked. Then go to
**Configuration → Web services → Mapy.com** (`/admin/config/services/mapycom`) to
enter your API key — see [Configuration](../configuration/index.md) for the full
walkthrough and for how to add the map field to your content.
