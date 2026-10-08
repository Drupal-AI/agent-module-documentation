# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Internal Page Cache** module (`page_cache`) — the module depends on it and
  extends it so the low-vision and normal versions of a page are cached separately.

## Install with Composer

From the project root:

```bash
composer require drupal/visually_impaired_module -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/visually_impaired_module -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en visually_impaired_module -y
```

There are no submodules.

## Suggested companion theme

The module is designed to pair with the separate **`visually_impaired_theme`** project,
which provides a ready-made GOST-compliant low-vision theme. It is optional — you can point
the module at any enabled theme — but installing it gives you a compliant look out of the
box:

```bash
composer require drupal/visually_impaired_theme -W
drush theme:enable visually_impaired_theme -y
```

After enabling, continue to [Configuration](../configuration/index.md) to choose the theme
and place the switch buttons.
