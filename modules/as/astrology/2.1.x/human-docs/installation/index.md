# Installation

## Requirements

Astrology is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/astrology -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/astrology -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en astrology -y
```

## After enabling

Place the horoscope block at **Structure → Block layout**
(`/admin/structure/block`) in the region where you want it to appear. See the
[overview guide](../index.md#how-to-use-it).
