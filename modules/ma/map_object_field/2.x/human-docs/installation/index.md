# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency.
- A **Google Maps JavaScript API key** — the current version renders maps with
  Google Maps, so you'll need a key from the Google Cloud console before the field
  will work. See [Configuration](../configuration/index.md).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/map_object_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/map_object_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en map_object_field -y
```

## Verify it worked

Go to **Configuration → Map Object Field** (`/admin/config/map-object-field`). If
the settings page loads, the module is installed — enter your Google Maps API key
there and then add the field to a content type, as described in
[Configuration](../configuration/index.md).
