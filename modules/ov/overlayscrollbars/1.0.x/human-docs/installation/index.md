# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No contributed module dependencies. The module integrates the OverlayScrollbars
  JavaScript plugin for its front‑end effect.

## Install with Composer

From the project root:

```bash
composer require drupal/overlayscrollbars -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/overlayscrollbars -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en overlayscrollbars -y
```

## Grant the permission

The module provides its own permission for administering it. Grant it to the roles
that should manage the settings under **People → Permissions**.

## Verify it worked

Open the module's settings page, add an HTML element/selector to apply the plugin
to (for example a scrollable container), save, and reload the site. The targeted
element should now display the custom overlay‑style scrollbars instead of the
browser's native ones.
