# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs)** 2.x
  or 3.x (`drupal/layout_paragraphs: ^2.0 || ^3.0`) — and, through it,
  Paragraphs. This is the one hard dependency; Composer pulls it in for you.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_paragraphs_limit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_limit -y
```

Drush enables Layout Paragraphs automatically if it is not already on. Once the
module is active, head to
[Configuration](../configuration/index.md) to set up your region rules — until
you do, nothing is restricted and every region behaves exactly as it did before.

## Submodules

Layout Paragraphs Limit ships no submodules.
