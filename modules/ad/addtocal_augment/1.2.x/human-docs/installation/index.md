# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Date Augmenter** module (`drupal/date_augmenter` `^1.1`) — Composer pulls
  this in automatically, and Drupal enables it as a dependency.
- A date field that uses a **Date Augmenter‑aware formatter** to actually render
  the links. [Smart Date](https://www.drupal.org/project/smart_date) is the common
  choice. This isn't a hard dependency, but without such a formatter the settings
  save yet nothing renders.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/addtocal_augment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies — including the Date Augmenter module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/addtocal_augment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addtocal_augment -y
```

This also enables Date Augmenter if it isn't already on. Once enabled, the **Add to
Calendar Links** augmenter appears in the Date Augmenter section of any compatible
date field's formatter settings — see the
[main guide](../index.md#how-to-use-it) for how to turn it on and configure it.
There's no configuration form and no permissions to grant.

This module ships no submodules.
