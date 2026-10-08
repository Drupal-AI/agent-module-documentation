# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **System** module (`system`) — always present on a Drupal site, so
  there's nothing extra to install. No jQuery and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/height_equalizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/height_equalizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en height_equalizer -y
```

## Verify it worked

Log in as an administrator and open **Configuration → User interface → Height
Equalizer**. If the settings form appears, the module is installed. Add a CSS
selector (see [Configuration](../configuration/index.md)), save, clear caches,
and check that the matching elements now line up to a common height.
