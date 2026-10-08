# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no special third-party requirements. Leaflet ships
  with the module's own library definitions.

## Install with Composer

From the project root:

```bash
composer require drupal/map_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/map_provider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en map_provider -y
```

## Verify it worked

There's no admin page to check — this is developer infrastructure. Once enabled,
its plugin manager and render element are available to your code, and the built-in
OpenStreetMap provider is registered. Confirm it by building a map with the render
element (see the [overview](../index.md#how-to-use-it)) or by adding your own
provider YAML and checking it's discovered.
