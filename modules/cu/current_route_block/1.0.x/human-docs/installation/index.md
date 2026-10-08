# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, and no third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/current_route_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/current_route_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en current_route_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm that
**Current Route Block** appears in the list of blocks you can place. Add it to a
region and view a page — the block should show the current route's name,
parameters, and path.
