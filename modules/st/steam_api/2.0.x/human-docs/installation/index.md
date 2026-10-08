# Installation

## Requirements

Steam API needs:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- A **Steam Web API key**, which you create for free on Steam's developer page.
  The settings form links to it.

There are no other module, Composer, or PHP library requirements — it uses
Drupal's built-in HTTP client, cache, and logger.

## Install with Composer

From the project root:

```bash
composer require drupal/steam_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/steam_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en steam_api -y
```

## After installing

The module does nothing visible until you enter your Steam API key at
`/admin/config/services/steam_api` and write code that uses its services. Every
service getter returns an empty array if no key is configured. See
[Configuration](../configuration/index.md).
