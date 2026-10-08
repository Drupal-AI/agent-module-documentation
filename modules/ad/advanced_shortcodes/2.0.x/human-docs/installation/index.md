# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Shortcode** module (`shortcode`), which provides the
  text-format filter this module plugs its shortcodes into.

There are no third-party Composer or PHP library requirements — the module ships
its own Bootstrap CSS/JS.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_shortcodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Shortcode module if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_shortcodes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_shortcodes -y
```

Enabling it also enables the Shortcode dependency if it is not already on.
Installing the module does not turn any shortcodes on by itself — you next have to
enable the shortcode filter on a text format and tick the shortcodes you want.
See [Configuration](../configuration/index.md).
