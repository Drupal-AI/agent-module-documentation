# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). The project page
  notes Drupal 11 or later for full functionality.
- Core's **Media** (`media`), **Field** (`field`), and **System** (`system`)
  modules — standard on most sites.

There are no third‑party Composer or PHP library requirements, and **no API key is
needed** to use the Grout image service.

## Install with Composer

From the project root:

```bash
composer require drupal/grout_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/grout_image -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en grout_image -y
```

## Verify it worked

Go to **Configuration → Media → Grout Image** (`/admin/config/media/grout-image`)
and confirm the settings form loads. Then, on a content or media type that has an
entity‑reference field pointing to media, open **Manage display** and check that the
**Grout Fallback** formatter is available for that field.

Next, see [Configuration](../configuration/index.md) to set your site‑wide defaults
and configure the formatter.
