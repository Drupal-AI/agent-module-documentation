# Installation

## Requirements

- **Drupal 10.6 or later, or Drupal 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node**, **Media**, **System**, and **Tour** modules (all part of
  Drupal core; Tour ships with core and is used for the module's guided tour).
- The **Search API Exclude Entity** (`search_api_exclude_entity`) module, which
  provides the boolean "exclude from search" field this module reads and writes.
- A boolean field on your media entities used to indicate exclusion status, plus
  Search API set up on your site.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_node_search_exclusion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including Search API Exclude Entity — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_node_search_exclusion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_node_search_exclusion -y
```

Drupal will enable the required dependencies (Node, Media, System, Tour, and
Search API Exclude Entity) at the same time.

## Verify it worked

Log in as an administrator and visit **Configuration → Search and metadata →
Media Node Search Exclusion** (`/admin/config/search/media-node-search-exclusion`).
If the settings form loads, the module is installed. Continue to
[Configuration](../configuration/index.md) to point it at your exclusion field and
choose your propagation rules — nothing is propagated until you do.
