# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_container -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_container -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_container -y
```

Enabling the module doesn't change anything on its own — it just makes a new
**Reference method** available. To actually use grouped selection, turn it on for
a specific term reference field, described in
[Configuration](../configuration/index.md).
