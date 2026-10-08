# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- No other modules are required. It works well with
  [Block Visibility Groups](https://www.drupal.org/project/block_visibility_groups)
  and any other consumer of Drupal's condition system.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/request_parameter_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_parameter_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_parameter_condition -y
```

## Verify it worked

Place or edit a block at **Structure → Block layout** and open its visibility
settings. The new **request parameter** condition should appear alongside the
core conditions. See [How to use it](../index.md#how-to-use-it) for the rest.
