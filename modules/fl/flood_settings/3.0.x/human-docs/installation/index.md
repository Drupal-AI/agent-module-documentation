# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

That's it. Flood settings has no third‑party Composer or PHP library
requirements and no module dependencies — it only edits core's built‑in
`user.flood` configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/flood_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flood_settings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flood_settings -y
```

Then grant the **Manage flood settings** permission and open the form — see
[Configuration](../configuration/index.md).

## Submodules

None — Flood settings ships as a single module.
