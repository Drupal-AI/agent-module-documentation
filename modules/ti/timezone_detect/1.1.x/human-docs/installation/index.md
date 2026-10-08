# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No dependencies beyond Drupal core. The jsTimezoneDetect (`jstz`) library is
  bundled with the module, so there is nothing extra to download.

## Install with Composer

From the project root:

```bash
composer require drupal/timezone_detect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/timezone_detect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en timezone_detect -y
```

## After enabling

The module starts working right away in its default mode. To get the most out of the
recommended mode, check the regional setting described in
[Configuration](../configuration/index.md) — Drupal's status report will also warn
you there if the setting needs adjusting.
