# Installation

## Requirements

Search Exclude is lightweight. It needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Search** module (`search`) enabled — this is the only dependency, and Drupal
  enables it automatically when you turn on Search Exclude.

There are no third-party Composer or PHP library requirements. It only affects core
Search, not Search API or Solr.

## Install with Composer

From the project root:

```bash
composer require drupal/search_exclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_exclude -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_exclude -y
```

Enabling the module changes nothing on its own — it simply makes the **Content (Exclude)**
search plugin available. To actually exclude any content types you must create a search
page that uses it; see [Configuration](../configuration/index.md).
