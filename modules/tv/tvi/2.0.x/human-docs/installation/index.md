# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) and **Taxonomy** module (`taxonomy`) enabled —
  the only dependencies. Drupal enables them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tvi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/tvi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tvi -y
```

Enabling the module changes nothing on its own — term pages keep using the core
default View until you assign a different one. Head to
[Configuration](../configuration/index.md) to point terms, vocabularies, or the whole
site at the View you want.
