# Installation

## Requirements

- **Drupal 10.6+, 11.3+, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`).
- Core's entity‑reference and Field UI are all you need; there are no third‑party
  Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_entity_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_entity_reference -y
```

Once enabled, the tag widget becomes available on the **Manage form display**
screen for any entity‑reference field — see [How to use
it](../index.md#how-to-use-it).
