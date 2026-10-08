# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block content** (`block_content`), **Layout Builder**
  (`layout_builder`), and **Inline Entity Form** (`inline_entity_form`) modules.
  Drupal enables these as dependencies.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_description_modifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_description_modifier -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_description_modifier -y
```

After enabling, grant the permission this module provides to the roles that build
layouts, then work with inline blocks in Layout Builder — see
[How to use it](../index.md#how-to-use-it).
