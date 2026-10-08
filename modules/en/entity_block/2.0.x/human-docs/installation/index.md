# Installation

## Requirements

Entity Block is lightweight and depends only on Drupal core:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Block** module — you place these blocks through Block layout or Layout
  Builder, so you'll want at least one of those enabled to use the module.

There are no third-party Composer packages or PHP libraries to install, and no
other contributed modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_block -y
```

There is nothing to configure after enabling. Go to **Block layout** (or a Layout
Builder section) and place one of the new **Entity Block** blocks — see the
[overview](../index.md#how-to-use-it) for the step-by-step.

There are no submodules.
