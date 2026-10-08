# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Search API** module (`search_api`) — the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_trim_whitespace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_trim_whitespace -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_trim_whitespace -y
```

## Verify it worked

Open a Search API index under **Configuration → Search and metadata → Search
API** and go to the **Processors** tab. The trim-whitespace processor should be
available to enable. Turn it on, position it after the HTML Filter, save, and
re-index — then check a search result snippet to confirm the extra spaces are
gone.
