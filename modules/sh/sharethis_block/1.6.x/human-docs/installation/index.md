# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **ShareThis account** with a **property ID** (sign up at sharethis.com). The
  buttons, networks, and styling are configured there.

There are no third‑party Composer or PHP library requirements — the ShareThis
script is loaded at runtime from ShareThis's CDN, not installed locally.

## Install with Composer

From the project root:

```bash
composer require drupal/sharethis_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sharethis_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharethis_block -y
```

## Next steps

Nothing appears until you enter your property ID and place the block. Go to
**Configuration → User interface → Sharethis** to enter your settings, then to
**Structure → Block layout** to place the block — the
[Configuration](../configuration/index.md) guide walks through both. There are no
submodules.
