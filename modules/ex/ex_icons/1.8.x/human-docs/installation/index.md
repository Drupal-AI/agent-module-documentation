# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules and no third‑party Composer or PHP libraries are required.

Remember that the module **ships no icons** — you'll need a `dist/icons.svg`
sprite sheet in a module or theme for there to be any icons to use.

## Install with Composer

From the project root:

```bash
composer require drupal/ex_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ex_icons -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ex_icons -y
```

The module ships no submodules. Once enabled and once a sprite is present, add an
Icon field or use the Twig function as described in the
[main guide](../index.md#how-to-use-it). After editing a sprite's contents, refresh
the icon cache with `drush cache-clear ex-icons`.
