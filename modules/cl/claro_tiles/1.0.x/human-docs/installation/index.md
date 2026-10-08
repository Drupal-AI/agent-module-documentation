# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Claro** admin theme must be enabled — the module's CSS targets Claro, so it
  has no effect under any other admin theme.

There are no third‑party Composer or PHP library requirements, and no module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/claro_tiles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/claro_tiles -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en claro_tiles -y
```

That is all that is needed. There is no settings form to fill in.

## Verify it worked

Make sure **Claro** is your active administration theme (check under
**Appearance**), then reload an admin listing page. The listings and action links
that the module restyles should now display as tiles instead of the default lines.
