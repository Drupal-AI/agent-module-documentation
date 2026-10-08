# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`, and the
  effect works across core 8–11).
- No special requirements — no module dependencies and no PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/square_pixels_scale -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/square_pixels_scale -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en square_pixels_scale -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**, edit or create a style, and open
the **Add a new effect** dropdown. You should now see **Square pixels scale** among
the available effects. See [Configuration](../configuration/index.md) for how to
set it up.
