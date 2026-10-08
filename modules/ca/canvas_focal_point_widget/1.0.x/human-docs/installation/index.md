# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Canvas** module (`drupal/canvas`) — the Experience Builder page builder
  this widget plugs into. It must be installed and enabled first.
- This release is an early alpha (**1.0.0‑alpha1**), so treat it as work in
  progress and test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_focal_point_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas if it is not already present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_focal_point_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_focal_point_widget -y
```

Enabling it also enables Canvas if that has not been turned on yet. Once active,
the focal‑point picker is available when you edit images in the Canvas builder.
There is no separate configuration step.
