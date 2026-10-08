# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is part of standard Drupal and is
  enabled automatically as a dependency.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/insert_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/insert_view -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en insert_view -y
```

## Next steps

Enabling the module does not turn the tag on by itself — you must enable the
**Insert View** filter on at least one text format first. See the
[main guide](../index.md#how-to-use-it) for that step, the tag syntax, and the
important security note about which formats to enable it on.
