# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's entity‑reference fields (part of a standard Drupal install). There are no
  other module, Composer, or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autocreate_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocreate_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocreate_access -y
```

The module ships no submodules and has no configuration. As soon as it is enabled,
entity‑reference autocomplete widgets begin checking create access before offering
the "create new" option — see [How to use it](../index.md#how-to-use-it).
