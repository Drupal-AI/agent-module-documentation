# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No dependent modules, no PHP requirement, and no third-party Composer libraries.

This is an early release (`1.0.0-beta1`), so test it on a non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/scrollmagic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scrollmagic -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scrollmagic -y
```

Enabling the base module makes the ScrollMagic library available to Drupal.

## Submodule — optional admin UI

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ScrollMagic UI** | `scrollmagic_ui` | An administrative interface for configuring scroll scenes and effects, so you can set up ScrollMagic behaviour without hand-writing all of the JavaScript. |

Enable it only if you want the configuration UI:

```bash
drush en scrollmagic_ui -y
```

The submodule requires the base ScrollMagic module, which is already present once
you have installed it above.
