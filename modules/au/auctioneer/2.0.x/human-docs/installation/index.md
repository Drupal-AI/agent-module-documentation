# Installation

## Requirements

Auctioneer needs:

- **Drupal 8.8.8+, 9, or 10** (`core_version_requirement: ^8.8.8 || ^9 || ^10`).
- Core's **System** module (8.8.8 or newer) and core **Views** (`views`).
- The contrib **Entity** module (`entity`).

Composer resolves the Entity dependency for you. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auctioneer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Entity module
and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auctioneer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auctioneer -y
```

Views and the Entity module are enabled automatically as dependencies.

## Next step

With the module enabled, define your auction and bid types and their handler logic
under **Structure → Auctioneer** — see [Configuration](../configuration/index.md).
