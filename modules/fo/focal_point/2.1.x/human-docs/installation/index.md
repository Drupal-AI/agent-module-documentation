# Installation

## Requirements

Focal Point needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`) — Drupal enables it automatically as a
  dependency.
- The contrib **Crop API** module (`crop`, version `^2.3`) — this is where the
  focal‑point coordinates are actually stored, so it is required. Composer pulls
  it in for you.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/focal_point -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed and bring in the required **Crop API** module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/focal_point -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en focal_point -y
```

This enables Focal Point along with the Crop API module it depends on.

## Next steps

Enabling the module does not change any crops on its own — it just makes the
focal‑point widget and image effects available. To put them to work, follow the
two‑step **How to use it** walkthrough on the [guide overview](../index.md):
switch your image field to the **Image (Focal Point)** widget on *Manage form
display*, then add a **Focal Point Scale and Crop** (or another focal‑point)
effect to the image styles you want to crop around the chosen point.
