# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 8.3 or later**.
- The **Search API** module (`search_api`, `^1.37`).
- Core's **Key** module (`key`, `^1.22`) — used to store the Manticore connection
  password securely.
- Core's **Language** module (`language`).
- The official Manticore PHP SDK (`manticoresoftware/manticoresearch-php ^4.0`) —
  installed automatically by Composer with the module.
- A running **Manticore Search** server that Drupal can reach over its HTTP JSON
  API. Setting up the Manticore server itself is outside the scope of this module;
  see the Manticore documentation. The module is developed and tested against
  Manticore Search 29.x.

Drupal will enable the module dependencies automatically. There are no extra
third-party PHP library requirements to add by hand for basic use — the Manticore
PHP SDK comes in with the module. (Server-side map clustering additionally needs
`beste/latlon-geohash`; see Configuration.)

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_manticore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_manticore -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_manticore -y
```

This also enables the Search API, Key, and Language modules if they aren't already
on. Once enabled, continue to [Configuration](../configuration/index.md).
