# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **HAL** module (`hal`, package `drupal/hal ^1.0 || ^2.0`). Better
  Normalizers only affects the `hal_json` format, so HAL must be present and
  enabled. On Drupal 11 the HAL module lives in contrib, so Composer will pull it
  in as a dependency of this module.
- Optionally, core's **Menu link content** module (`menu_link_content`) — only
  needed if you want the menu-link normalizer improvements. It is not required for
  the file-related improvements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_normalizers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `drupal/hal` package this module depends
on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/better_normalizers -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Better Normalizers together with HAL (Drupal will enable HAL automatically
as a dependency if it is not already on):

```bash
drush en better_normalizers -y
```

That is the entire setup — there is no configuration. From this point, any
`hal_json` serialization uses the improved file, file-field, and menu-link
normalizers. If you also want the menu-link embedding, make sure
`menu_link_content` is enabled:

```bash
drush en menu_link_content -y
```

This module has no submodules.
