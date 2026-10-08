# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A **Bing Webmaster API key** for the site you want to submit URLs for.

There are no additional module dependencies and no third-party Composer or PHP
library requirements listed.

## Install with Composer

From the project root:

```bash
composer require drupal/bing_indexing_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bing_indexing_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bing_indexing_api -y
```

After enabling, continue to [Configuration](../configuration/index.md) to enter your
API key and choose which content changes submit URLs to Bing.
