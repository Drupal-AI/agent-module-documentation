# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core's **Taxonomy** module (the module stores its colors and filter
  tags as taxonomy terms). Taxonomy is part of the standard install.
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/colorpalette -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/colorpalette -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorpalette -y
```

Enabling the module creates two vocabularies automatically:

- **Colors** (`colorpalette_colors`) — one term per approved color, each with a
  hexcode field.
- **Filter Tags** (`colorpalette_filter_tags`) — optional grouping labels such as
  Light and Dark.

## After enabling

There is no settings page to visit. Next steps:

1. Add your approved colors at **Structure → Taxonomy → Colors**.
2. Attach the **Color Palette** widget to a field on the entity's **Manage form
   display** tab.
3. Optionally grant the **Administer palette** permission (at
   **People → Permissions**) to roles that should be able to add colors on the
   fly.

See the [main guide](../index.md) for the full walkthrough.
