# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- The **Slick** module, version **3.x or newer** (`drupal/slick:^3.0`). This is a
  hard dependency; Composer installs it automatically when you require Slick
  Extras. Slick in turn needs the Slick JavaScript library — follow Slick's own
  installation notes for that.

There are no third‑party PHP library requirements from Slick Extras itself.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Slick and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slick_extras -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick_extras -y
drush cr
```

Clearing the cache is important: the extra skins only appear in the Slick **Skin**
dropdown after a cache rebuild.

## Sub‑modules — enable only if you are learning or developing

Slick Extras bundles two optional sub‑modules. They are teaching/scaffolding tools,
not something to rely on in production:

| Sub‑module | Machine name | What it adds |
|---|---|---|
| **Slick Example** | `slick_example` | Sample optionsets (prefixed `X`), Slick image styles, a `slick_x` demo View with blocks, and an example skin. It also depends on **Slick Views**, which Composer/Drush will require. Clone what you need, then uninstall it. |
| **Slick Development** | `slick_devel` | A settings form and a debug JavaScript loader, useful only while developing the Slick library itself. |

Enable one with, for example:

```bash
drush en slick_example -y
```

Because the maintainers frame the whole project as example code, the recommended
lifecycle is: install it, copy the skin/optionset/View you want into your own
theme or module, then **uninstall Slick Extras** for production.
