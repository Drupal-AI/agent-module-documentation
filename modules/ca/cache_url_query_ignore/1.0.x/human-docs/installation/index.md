# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_url_query_ignore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_url_query_ignore -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_url_query_ignore -y
```

After enabling, set the list of query parameters to ignore — see the module's own
[`agent/`](../agent/start.md) docs for the configuration mechanism. Remember to
include only parameters that do not change what the page renders, or you risk serving
the wrong cached content.
