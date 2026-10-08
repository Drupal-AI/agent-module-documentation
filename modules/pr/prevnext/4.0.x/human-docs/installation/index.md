# Installation

## Requirements

- **Drupal 11.2** or newer (`core_version_requirement: ^11.2`).
- No other module dependencies — PrevNext runs on core alone.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/prevnext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevnext -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevnext -y
```

There are no submodules. After enabling, head to the settings page to turn PrevNext
on for the entity types and bundles you want and to choose how the links render —
the full walkthrough is in the [main guide](../index.md#how-to-use-it).
