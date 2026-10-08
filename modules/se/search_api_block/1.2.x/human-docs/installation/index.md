# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) — this is a hard dependency, and you
  will need at least one Search API view page with an exposed keyword filter for
  the block to submit to.

### Optional but suggested

- **Token** (`drupal/token`) — enables token replacement in the block's Search
  page path and other text fields.
- **Better Search** (`drupal/better_search`) — makes it easy to style the search
  input with animation.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_block -y
```

This enables Search API too if it isn't already on. Next, place and configure the
block — see [Configuration](../configuration/index.md).
