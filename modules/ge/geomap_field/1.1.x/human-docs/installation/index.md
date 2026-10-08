# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — part of the standard install.
- Two companion contrib modules that do the geocoding and map rendering:
  **Geolocation Provider** (`geolocation_provider`) and **Map Provider**
  (`map_provider`). Composer pulls these in for you with the `-W` flag below.

There are no special PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/geomap_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Geolocation
Provider and Map Provider modules (and update any shared dependencies) at the same
time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/geomap_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geomap_field -y
```

Drupal will enable Geolocation Provider and Map Provider automatically as
dependencies.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**
and confirm that **Geomap** appears in the list of available field types. If it
does, the module and its providers are installed correctly — continue with the
field setup described in "How to use it" on the [overview page](../index.md).
