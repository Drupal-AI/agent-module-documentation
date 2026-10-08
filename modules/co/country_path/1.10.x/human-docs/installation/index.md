# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.3 or 8.x** (`php: ^7.3 || ^8.0`).
- The **Domain** module (`drupal/domain`, `^1.0.0-beta7 || ^2 || ^3`) — required.
- Optional: core's **Language** module, if you want language detection from the
  country/path prefix. Optional: the **Domain Alias** submodule, if you want to
  match a country prefix through an alias pattern.

## Install with Composer

From the project root:

```bash
composer require drupal/country_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Domain module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/country_path -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en country_path -y
```

This enables Domain too if it isn't already on. If you want language detection
from the country prefix, make sure the **Language** module is enabled — Country
Path adds its language negotiator automatically, whether Language is enabled
before or after it:

```bash
drush en language -y
```

Country Path ships no submodules of its own. Once enabled, configure a country
prefix on each domain record — see [Configuration](../configuration/index.md).

## Uninstalling

On uninstall, Country Path cleans up after itself: it removes its
`country-path-language-url` negotiator from the language URL, interface, and
content negotiator configuration.
