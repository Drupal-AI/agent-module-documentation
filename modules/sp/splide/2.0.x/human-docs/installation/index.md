# Installation

## Requirements

- **Drupal 8.8 or newer** (`core_version_requirement: >=8.8`).
- The **Blazy** module (`drupal/blazy` `^2.17 || ^3.0.1`) — installed automatically by
  Composer. Splide uses Blazy for lazy‑loading and shared rendering plumbing.
- The external **Splide JS library** (version 4+, e.g. 4.1.4) placed under `/libraries` —
  this is **not** a Composer PHP package by default and must be added separately (see
  below). Without it, the sliders won't initialise.

## Install the module with Composer

From the project root:

```bash
composer require drupal/splide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Blazy and update any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/splide -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the Splide JS library

Splide needs the Splide JavaScript library in your `/libraries` folder. Place it at
`/libraries/splide/` (or `/libraries/splidejs--splide/` if you install it via a Composer
asset workflow). The result should give you the Splide JS and CSS files under that folder.
Any optional Splide extensions (auto‑scroll, intersection) go in their own `/libraries`
subfolders.

## Enable the module

```bash
drush en splide -y
```

## Enable the submodules you need

Splide ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Splide UI** | `splide_ui` | The admin interface for creating and editing optionsets at **Configuration → Media → Splide**, plus the `administer splide` permission and the module's CSS‑toggle settings form. Most sites want this. |
| **Splide X** | `splide_x` | Ready‑made example optionsets (`x_main`, `x_carousel`, `x_grid`, `x_fullscreen`…), example image styles, a demo View, and an extra skin — great for learning working setups. |

Enable them individually:

```bash
drush en splide_ui -y
drush en splide_x -y
```

## Verify it worked

With **Splide UI** on, visit **Configuration → Media → Splide**
(`/admin/config/media/splide`). You should see the optionset list (with the shipped
`default` optionset). Create or duplicate an optionset, then apply it via a field formatter
or the Views style — see [How to use it](../index.md#how-to-use-it) on the overview page.
If sliders render as a plain stacked list instead of a carousel, the Splide JS library is
usually missing from `/libraries`.
