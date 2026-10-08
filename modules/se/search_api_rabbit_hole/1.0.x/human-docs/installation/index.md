# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Rabbit Hole** module (`rabbit_hole`).
- The **Search API** module (`search_api`).

The module only works when both Rabbit Hole and Search API are enabled. Drupal will
pull them in as dependencies. There are no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_rabbit_hole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_rabbit_hole -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_rabbit_hole -y
```

This also enables Rabbit Hole and Search API if they aren't already on.

## Turn the processor on

Edit your Search API index, open its **Processors** tab, and enable **Indexing
Rabbit Hole Filter**. Optionally adjust which Rabbit Hole plugins trigger
exclusion (it defaults to the hiding ones — Access Denied and Page Not Found), save,
and re-index your content so hidden entities drop out of search results.
