# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Metatag** module (`drupal/metatag`, `^2.0`) — Custom Meta extends it, so it
  is required and Composer pulls it in automatically.

There are no other third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_meta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in Metatag if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_meta -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_meta -y
```

Drupal enables Metatag automatically as a dependency if it isn't already on. The
module ships one example definition (a `sitename` tag) so you can see how the
overview works immediately.

## Verify it worked

Go to **Configuration → Search and Metadata → Metatag → Custom Meta Tags**
(`/admin/config/search/metatag/custom-meta`). You should see the overview table with
the example `sitename` tag. Next, see [Configuration](../configuration/index.md) to
add your own tags.
