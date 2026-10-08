# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- **Drush** — the module is entirely command‑line based.

Optional companion:

- [Image Effects](https://www.drupal.org/project/image_effects) — adds extra image
  effects that these commands can then create and configure.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_styles_drush -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_styles_drush -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_styles_drush -y
```

## Verify it worked

Run `drush isl` to list your image styles, or `drush ise` to list the available
effects. If those commands run, the module is installed correctly. See the
[manual setup guide](../index.md) for the full command reference.
