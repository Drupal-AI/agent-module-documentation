# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Gutenberg** module (`gutenberg`) — the editor these blocks extend. Install
  it separately (`composer require drupal/gutenberg`) if it is not already present.
- Core **Media** (`media`) and **Media Library** (`media_library`) — several
  blocks are media-aware. Drupal enables these as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_gutenberg_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in dependencies where available.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_gutenberg_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_gutenberg_blocks -y
```

Make sure Gutenberg itself is enabled and configured as the editor for the
content types you author, then edit a Gutenberg document to find the new blocks in
the inserter.
