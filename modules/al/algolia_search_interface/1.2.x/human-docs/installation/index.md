# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- An **Algolia account**, an Algolia application (Application ID), and at least a
  **search-only API key**. Algolia is an external hosted service — the module
  provides the interface, but the search index lives at Algolia.

There are no additional Composer or PHP library requirements declared by the
module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/algolia_search_interface -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/algolia_search_interface -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en algolia_search_interface -y
```

After enabling, connect the interface to your Algolia application using your
**Application ID** and **search-only API key**, and make sure your content is
indexed in Algolia. See [the overview](../index.md) for the security notes on
which key to expose and what to index.
