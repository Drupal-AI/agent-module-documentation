# Installation

## Requirements

Google Map Field is self-contained. It needs:

- **Drupal 9.4+, 10, or 11** (`core_version_requirement: ^9.4 || ^10.0 || ^11`).
- Core's **Field** module (`field`), which is part of standard Drupal and is
  enabled automatically as a dependency.
- No third-party Composer packages, PHP extensions, or bundled JavaScript
  libraries.
- A **Google Maps JavaScript API key** if you plan to use the Google-based widget
  or formatters — they need a valid key to load map tiles. The OpenLayers widget
  and formatter work without one.

## Install with Composer

From the project root:

```bash
composer require drupal/google_map_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_map_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_map_field -y
```

Enabling it makes the **Google Map Field** field type, its two widgets, and its
three formatters available, plus the global API-key settings form.

## Verify it worked

Confirm the settings form loads at **Configuration → Web services → Google Map
Field settings** (`/admin/config/services/gmap-field-settings`), and that **Google
Map Field** appears as a field type on a bundle's **Manage fields → Add field**
screen. See [Configuration](../configuration/index.md) to set the API key and
attach a field.
