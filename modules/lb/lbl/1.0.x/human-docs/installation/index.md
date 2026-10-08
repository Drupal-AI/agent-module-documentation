# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Layout Discovery** (`layout_discovery`) and **Layout Builder**
  (`layout_builder`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lbl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lbl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lbl -y
```

The module installs as usual — there is nothing more to switch on. To make the
responsive behaviour match your design, define breakpoints (and, if you like,
your own layout variants) in your front-end theme; see the "How to configure it"
section of the [overview](../index.md).

## Verify it worked

Edit a Layout Builder layout, add a section, and confirm the layouts this module
provides appear among the layout choices. Place blocks into a layout's regions,
save, and check that the generated grid CSS arranges them responsively across
breakpoints.
