# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block** module (`block`) and **Node** module (`node`), both of which
  Drupal enables automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_content_type_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_content_type_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_content_type_visibility -y
```

Once enabled, the new **Content type** condition is available on every block's
visibility settings — see [How to use it](../index.md#how-to-use-it). There is no
required configuration.
