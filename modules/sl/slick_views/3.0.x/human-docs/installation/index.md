# Installation

## Requirements

Slick Views is a small bridge module, but it only works on top of a couple of other pieces:

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), which covers Drupal 9.4+, 10, and 11.
- Core's **Views** module (`views`) enabled — part of Drupal's standard install.
- The **Slick** module (`drupal/slick ^3.0`), which provides the carousel **optionsets** and the underlying Slick JavaScript library. Composer pulls this in for you as a dependency, and Drupal enables it automatically. Note that the Slick module in turn expects the Slick carousel front‑end library to be available; if your carousels render as a plain list, check the Slick module's own status report and library setup.

There are no additional PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared dependencies — including the **Slick** module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slick_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick_views -y
```

Because Slick Views depends on **Slick** and **Views**, Drupal enables those at the same time — so this one command turns on everything you need. Slick Views ships no submodules. Once enabled, the **Slick Carousel** and **Slick Grouping** formats appear in the Views UI (see the [How to use it](../index.md#how-to-use-it) section), and you manage carousel presets in the Slick module at **Configuration → Media → Slick**.
