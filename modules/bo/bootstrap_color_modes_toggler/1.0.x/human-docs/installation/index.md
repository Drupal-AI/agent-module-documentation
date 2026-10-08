# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Bootstrap 5 theme that supports color modes** — this is what the toggle
  actually switches. Not a Composer requirement, but the module is only useful
  with such a theme.
- No module dependencies are declared, and it carries no permissions of its own.

There are no third‑party Composer or PHP library requirements.

> **Version note:** this release is an alpha (1.0.0‑alpha7), so test it before
> using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_color_modes_toggler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_color_modes_toggler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_color_modes_toggler -y
```

There are no submodules. Once enabled, place its toggle block from **Structure →
Block layout** — see the [overview](../index.md#how-to-use-it).
