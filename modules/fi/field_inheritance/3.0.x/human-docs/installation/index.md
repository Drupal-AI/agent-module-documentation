# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules are required. To inherit entity-reference-style fields
  such as paragraphs you will of course need the module that provides those field
  types.
- No extra Composer libraries or special PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_inheritance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_inheritance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_inheritance -y
```

There are no submodules. Once enabled, grant the **Administer field inheritance**
permission to trusted roles, then head to
[Configuration](../configuration/index.md) to set up your first inheritance.
