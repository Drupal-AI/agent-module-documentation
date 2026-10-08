# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) — the only dependency, and the source
  of the views this module marks up.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_mark_outdated -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_mark_outdated -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_mark_outdated -y
```

Once enabled, use the module's freshness marker within a Search API view (see the
main guide's *How to use it* section) and choose an outdated threshold that suits
each content type.
