# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Search API** (`search_api`), version **8.x-1.20 or newer** — the module
  declares `drupal/search_api: ^1.20` as a Composer requirement.
- Core's **Options** (`options`) and **User** (`user`) modules, both enabled by
  Drupal as dependencies.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_saved_searches -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it will bring Search API up to a compatible
version if necessary.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_saved_searches -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_saved_searches -y
```

## Verify it worked

Visit the saved-search type collection under the Search API administration area.
The module ships with a default type, so you should see at least one saved-search
type listed and ready to configure — see [Configuration](../configuration/index.md).
