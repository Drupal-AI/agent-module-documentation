# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The [Key](https://www.drupal.org/project/key) module (`key`) — a required
  dependency; the Mapbox token is stored in a Key entity, not in block config.
- A **Mapbox account** and a public (`pk.`) access token — see
  [Mapbox access tokens](https://docs.mapbox.com/help/getting-started/access-tokens/).
- Uses **Mapbox GL JS v2**; it does not work with older Mapbox GL versions.

## Install with Composer

From the project root:

```bash
composer require drupal/mapbox_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Key** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapbox_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapbox_block -y
```

This also enables the **Key** module if it isn't on already.

## Verify it worked

Go to **Configuration → Mapbox Block** (`/admin/config/mapbox-block`). If the
settings form loads, the module is installed — next, store your token in a Key and
select it, then add the block, as described in
[Configuration](../configuration/index.md).
