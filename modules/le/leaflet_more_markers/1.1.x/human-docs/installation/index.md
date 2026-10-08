# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Leaflet** module (`leaflet`) — provides the maps this module adds markers
  to. Declared dependency.
- The **Token** module (`token`) — the marker template uses tokens to pull each
  entity's marker values into the map. Declared dependency.
- A **Geofield** on the entity you want to map (that's where the coordinates come
  from).

The icon‑font stylesheets (Bootstrap Icons, Font Awesome, Line Awesome) are loaded
on demand from a CDN, so there are no third‑party libraries to install yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_more_markers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Leaflet and Token
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_more_markers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_more_markers -y
```

Drupal enables Leaflet and Token at the same time if they aren't already on. Then
add the Map marker field and wire up the Leaflet formatter — see the
[main page](../index.md) for the step‑by‑step.

## Submodules

None — Leaflet More Markers ships as a single module.
