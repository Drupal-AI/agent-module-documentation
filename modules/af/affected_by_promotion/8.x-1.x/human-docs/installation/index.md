# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7||^9||^10||^11`).
- **Drupal Commerce** with its **Commerce Promotion** module
  (`commerce_promotion`) — this is a hard dependency, since the whole module reads
  promotion data. Composer will pull Commerce in as needed.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/affected_by_promotion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Commerce packages — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/affected_by_promotion -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en affected_by_promotion -y
```

Enabling it also enables Commerce Promotion if it is not already on. There is no
required configuration — once your promotions exist, you can inspect what each one
affects.
