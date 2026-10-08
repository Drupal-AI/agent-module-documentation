# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contrib **Paragraphs** module (`paragraphs`) — this is the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
(including Paragraphs, if you don't already have it) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_class -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_class -y
```

There are no submodules and no settings form. To start using it, enable the "Paragraphs
wrapper class" behavior on a Paragraphs type — see the ["How to use it"
section](../index.md#how-to-use-it) on the overview page.
