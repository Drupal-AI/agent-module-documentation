# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **Acquia-hosted site** — the module targets the Acquia platform's caching
  layer, so it is meant for sites running on Acquia.

It has no module dependencies and no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cookie_vary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cookie_vary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cookie_vary -y
```

## After enabling

Configure **which cookies the cache should vary by**, and keep that list limited to
cookies that only affect public content. Do not include session or authentication
cookies — varying and caching by those can leak one user's private response to
another. See the [overview](../index.md) for the reasoning behind that warning.
