# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, third-party Composer packages, or PHP libraries are required.

Because it exposes internal cache information, install it on **development or
staging** environments rather than production.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_review -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_review -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_review -y
```

There is no required configuration. Once enabled, the review tool is available for
inspecting cache behaviour. Limit access to trusted developers, and disable or
remove the module before going to production.
