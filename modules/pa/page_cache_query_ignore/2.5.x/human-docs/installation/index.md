# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Internal Page Cache** module (`page_cache`) enabled — this is the cache
  the module modifies, and Drupal treats it as a dependency. The effect applies
  only to the anonymous page cache.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_cache_query_ignore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/page_cache_query_ignore -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_cache_query_ignore -y
```

If core's Internal Page Cache isn't already on, enable it too
(`drush en page_cache -y`) — without it there is no anonymous page cache for this
module to influence.

## Next steps

By default the parameter list is empty, so nothing is ignored until you configure
it. Head to [Configuration](../configuration/index.md) to list the tracking
parameters you want collapsed and choose the exclude/include behavior. After any
change, run `drush cr` so previously cached query‑string variants are cleared.
