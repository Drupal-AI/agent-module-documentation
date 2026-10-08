# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).

There are no additional Composer or PHP library requirements listed. The module
works with Drupal's core block tooling.

## Install with Composer

From the project root:

```bash
composer require drupal/block_component_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_component_library -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_component_library -y
```

There is no configuration form. Once enabled, use your custom blocks as reusable
components where you build layouts — see [How to use it](../index.md#how-to-use-it).
