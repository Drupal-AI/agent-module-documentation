# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Responsive Image** module (`responsive_image`) enabled — Drupal turns it
  on automatically as a dependency. You will need at least one **Responsive Image
  Style** configured (using the "Select a single image style" option per breakpoint).
- Core's **Media** module is needed only if you point the helper at a Media image
  reference field.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_background_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/responsive_background_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_background_image -y
```

That's all — there is no settings page and no submodules. Once enabled, the
`ResponsiveBackgroundImage::generateMediaQueries()` helper is available to call from
your theme or module code. See the [overview](../index.md#how-to-use-it) for a
worked example.
