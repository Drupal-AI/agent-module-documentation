# Installation

## Requirements

Search API Pages needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Search API** module (`drupal/search_api`, `^1.25`) — this is the only
  hard dependency, and it is pulled in by Composer.
- **At least one Search API index that already exists.** A search page binds to
  an index, so you need an index (backed by a server — a database backend works
  fine, no external service required) before a page can do anything useful. You
  set indexes up under **Configuration → Search and metadata → Search API**.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Search API
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_api_page -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_page -y
```

Drupal enables the Search API dependency for you if it is not already on.

## Next steps

If you don't yet have a Search API server and index, create them first under
**Configuration → Search and metadata → Search API** (a database-backed server
and index need no external services). Then head to
[Configuration](../configuration/index.md) to build your first search page.
