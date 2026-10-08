# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10.0||^11`). It can
  also still be installed on Drupal 8 to ease an upgrade path.
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.
- A Sessionize account with a published event, so you have a **web embed ID** to
  point the block at.

## Install with Composer

From the project root:

```bash
composer require drupal/sessionize_embed_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sessionize_embed_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sessionize_embed_block -y
```

## Next steps

Enter your Sessionize embed ID and choose a style on the settings form, then place
the block into a region. See [Configuration](../configuration/index.md).
