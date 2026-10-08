# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules — enabled
  automatically as dependencies.
- The contrib [Media Library form element](https://www.drupal.org/project/media_library_form_element)
  module (`media_library_form_element`, `^2.0`), which provides the media picker used on the
  block form. Composer pulls it in for you.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed — here it also brings in the required *Media Library form element* module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/media_library_block -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_block -y
```

Drupal enables the Media, Media Library and Media Library form element dependencies alongside
it. There is no settings form and no submodules. Once enabled, you'll find one block per media
type under the *Media* category in **Block layout** and Layout Builder — see
[Configuration](../configuration/index.md).
