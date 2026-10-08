# Installation

## Requirements

Block In Page Not Found is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on this module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_in_page_not_found -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_in_page_not_found -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_in_page_not_found -y
```

That is all the setup the module needs. There is no configuration form — the new
"Page not found" visibility condition is immediately available on every block.
See the [overview](../index.md#how-to-use-it) for placing a block on the 404
page.
