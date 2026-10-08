# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9.5 || ^10 || ^11`).
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_metrics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_metrics -y
```

Once enabled, the module begins recording cache performance in the background. It
adds some measurement overhead, so consider enabling it for a defined
performance-analysis period rather than leaving it on permanently.
