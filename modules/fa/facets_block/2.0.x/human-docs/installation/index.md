# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module (`drupal/facets`, `^2.0 || ^3.0`) enabled, with at least one
  facet source and some configured facets (typically on a Search API results view).
  Composer installs Facets as a dependency, and Drupal enables it when you turn on
  Facets Block.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Facets and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_block -y
```

The **Facets Block** block plugin becomes available on the Block layout page. No
submodules ship with this project.

## Next step

Enabling the module changes nothing on its own — you place and configure the block
at **Structure → Block layout**. See the "How to use it" section on the
[overview page](../index.md) for the walkthrough. Remember you need working Facets
configured first, otherwise there's nothing for the block to combine.
