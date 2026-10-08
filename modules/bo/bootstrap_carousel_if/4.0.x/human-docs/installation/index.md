# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies are declared.
- A theme that provides **Bootstrap's carousel JavaScript**. This is not a
  Composer requirement, but the formatter only emits markup — without Bootstrap's
  JS loaded by the theme, the carousel will not move.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_carousel_if -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_carousel_if -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_carousel_if -y
```

There are no submodules. Once enabled, choose the **Bootstrap carousel**
formatter on a multi‑value image field's **Manage display** screen — see the
[overview](../index.md#how-to-use-it).
