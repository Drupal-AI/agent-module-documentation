# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third-party Composer libraries and no other module dependencies.
- You will need a way to **generate** critical CSS files (for example Addy
  Osmani's *critical* or Filament Group's *criticalCSS*). This is a separate,
  external step — the module only consumes the files you produce.

## Install with Composer

From the project root:

```bash
composer require drupal/critical_css -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/critical_css -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en critical_css -y
```

There are no submodules.

## Next step

The module ships with no default configuration, so it is inert until you enable
it and set a directory. Head to [Configuration](../configuration/index.md) to turn
it on and point it at your critical CSS files.
