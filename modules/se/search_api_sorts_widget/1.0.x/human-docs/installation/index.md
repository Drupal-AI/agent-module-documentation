# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API Sorts** module (`search_api_sorts`) — this module extends it, so
  Search API Sorts must be present and set up first.
- Core's **Block** module (`block`), since the widget is placed as a block.

There are no third-party PHP library requirements.

> **Note:** this 1.0.x release is a **beta** (1.0.0-beta5), the project is
> minimally maintained, and it is not covered by Drupal's security advisory policy.
> Test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_sorts_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_sorts_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_sorts_widget -y
```

## Verify it worked

Open a Search API index that has Search API Sorts configured, under **Configuration
→ Search and metadata → Search API**. You should now see a **Sorts widget** tab
alongside the existing **Sorts** tab. That tab is where you switch the sorts over
to the form widget — see [Configuration](../configuration/index.md).
