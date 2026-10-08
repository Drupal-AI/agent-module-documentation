# Installation

## Requirements

OptGroup Taxonomy Select is a core-only module:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies and no third-party libraries. It works with core's
  Taxonomy and Field UI, which a standard site already has.

## Install with Composer

From the project root:

```bash
composer require drupal/optgroup_taxonomy_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/optgroup_taxonomy_select -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optgroup_taxonomy_select -y
```

Then assign the **Optgroup Term Select** widget to a taxonomy-term reference field
on its Manage form display — see the "How to use it" section of the
[overview](../index.md).

There are no submodules and nothing to configure globally.
