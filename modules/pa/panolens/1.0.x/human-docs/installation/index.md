# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other Drupal module dependencies. The module integrates the Panolens.js and
  Three.js JavaScript libraries as part of its own display code.

## Install with Composer

From the project root:

```bash
composer require drupal/panolens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panolens -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panolens -y
```

Panolens ships some Drush commands to help with setup; run `drush list` after
enabling to see what it provides.

## Verify it worked

Open the **Manage display** page of an entity that has an image or video field
(for example **Structure → Content types → *(type)* → Manage display**). You
should be able to choose a **Panolens** panorama formatter for that field. Set it,
add a genuine 360° image or video to a piece of content, and view it — an
interactive panorama viewer should appear.
