# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** module if you intend to place the slider as a block (enabled
  by default on standard installs).

There are no third‑party Composer or PHP library requirements — the slider
JavaScript library is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ds_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ds_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ds_slider -y
```

The module registers the **DS Slider** block, the `/ds-slider` page route, and
its bundled front‑end library. Disabling the module later removes all three.

## Verify it worked

Open the settings form (see [Configuration](../configuration/index.md)) and
confirm it loads. Then either place the **DS Slider** block from **Structure →
Block layout** or visit `/ds-slider` to see the slider render.
