# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Responsive Image** module (`responsive_image`) enabled — Drupal enables it
  automatically as a dependency. You will also need at least one configured
  **responsive image style** and a breakpoint group for the module to build preloads
  from.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_preload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/responsive_image_preload -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_preload -y
```

There is no configuration page. Once enabled, a **Generate preloads** checkbox
appears in the settings of any field using the *Responsive image* formatter — see
[How to use it](../index.md#how-to-use-it).
