# Installation

## Requirements

Meta Position is deliberately lightweight:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — always present on a standard site; it is the
  only dependency.
- No third-party Composer or PHP library requirements.

It works best with an admin theme that extends **Claro** (Drupal 10/11) or **Seven**
(older), since the adjustment is CSS aimed at those form layouts.

## Install with Composer

From the project root:

```bash
composer require drupal/meta_position -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meta_position -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meta_position -y
```

There are no submodules. The feature is **off by default** — enable it and pick your
content types on the settings form. See the
[overview](../index.md#how-to-use-it) for the step-by-step, including an important
note about the `administer site` permission that gates the settings page.
