# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module, which Drupal enables as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_unique -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_unique -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_unique -y
```

Enabling the module does **not** change any behaviour on its own — uniqueness is
off until you turn it on for a specific vocabulary. There is no global settings
page and no permissions. Continue to [Configuration](../configuration/index.md)
to enable it where you need it.
