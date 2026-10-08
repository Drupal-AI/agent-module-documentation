# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Book** module, enabled. On Drupal 8–10, Book is part of core. On **Drupal 11, Book is
  a contrib project** (`drupal/book`) and must be required separately. Note that
  `book_blocks.info.yml` does **not** declare Book as a dependency, so you need to enable it
  yourself — the blocks and services reference Book's code and won't work without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/book_blocks -W
```

On **Drupal 11**, also require the Book module if you don't already have it:

```bash
composer require drupal/book -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/book_blocks -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Book Blocks and make sure the Book module is on too:

```bash
drush en book book_blocks -y
```

Once enabled, the four blocks become available in Block layout / Layout Builder. See
[Configuration](../configuration/index.md) for placing them and configuring the Edit block.
