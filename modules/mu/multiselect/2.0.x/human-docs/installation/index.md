# Installation

## Requirements

Multiselect is a field widget with one small dependency. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Options** module (`options`) enabled — this is its only dependency, and
  Drupal will enable it automatically as a dependency when you turn on Multiselect.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multiselect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiselect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiselect -y
```

Once enabled, the **Multiselect** widget becomes available on eligible fields. See
[Configuration](../configuration/index.md) to attach it to a field and adjust the
box width.
