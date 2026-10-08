# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [Search API](https://www.drupal.org/project/search_api) (`search_api`).
- The **Elastic Enterprise Search PHP SDK**
  ([elastic/enterprise-search-php](https://github.com/elastic/enterprise-search-php)),
  installed automatically by Composer.
- An **Elastic Enterprise Search / App Search** instance — either self-hosted or
  an Elastic Cloud subscription. The module is the connector; it does not provide
  the search engine.

> This is a **beta** release (`1.0.0-beta4`) and the project is **not** covered by
> Drupal's security advisory policy — evaluate accordingly before production use.

## Install with Composer

Install via Composer so the Elastic PHP SDK is resolved for you:

```bash
composer require drupal/centarro_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in Search API and the Elastic SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/centarro_search -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en centarro_search -y
```

Drupal enables Search API at the same time as a dependency.

## Verify it worked

Confirm the module and Search API are enabled under **Extend**
(`/admin/modules`). The connector isn't doing anything until you create a Search
API server on the Elastic backend and index content — continue to
[Configuration](../configuration/index.md).
