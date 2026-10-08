# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Field** module (`field`) — enabled by default in a standard Drupal
  install; it is the only dependency.

There are no third‑party Composer or PHP library requirements, and the module
adds no front‑end libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/boolean_advanced_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/boolean_advanced_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en boolean_advanced_formatter -y
```

There are no submodules. Once enabled, choose the **Boolean Advanced** formatter
on a Boolean field's **Manage display** screen — see the
[overview](../index.md#how-to-use-it).
