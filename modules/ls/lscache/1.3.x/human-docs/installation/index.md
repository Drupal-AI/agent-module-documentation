# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Your site must be served by **LiteSpeed Web Server (LSWS)**, **OpenLiteSpeed**,
  or a **LiteSpeed PaaS** host — this module integrates with LiteSpeed's cache and
  does nothing on Apache or nginx.
- For automatic invalidation, the **[Purge](https://www.drupal.org/project/purge)**
  module — required by the `lscache_purger` submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/lscache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you plan to use automatic invalidation, also require
Purge:

```bash
composer require drupal/purge -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lscache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Add the required `.htaccess` directives

Header emission alone does nothing until LiteSpeed is told to consult its cache.
Add this block to your site's `.htaccess`:

```apache
<IfModule LiteSpeed>
  CacheLookup public on
  php_flag output_buffering off
</IfModule>
```

(For private per‑user caching, use `CacheLookup public on private on`.) The
Status report at `/admin/reports/status` has an **LSCache .htaccess directives**
row that reports OK / warning / error so you can confirm this is in place.

## Enable the module

```bash
drush en lscache -y
```

For automatic invalidation, also enable the purger submodule (which auto‑wires a
Purge pipeline):

```bash
drush en lscache_purger -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **LSCache Purger** | `lscache_purger` | Plugs into the Purge framework so content and config changes issue tag‑scoped PURGE requests and LiteSpeed drops the affected cached pages. Requires the Purge module. Set the purge host after enabling. |

## Verify it worked

1. Confirm the Status report shows the `.htaccess` directives as OK.
2. Turn on header injection in the settings form (once LiteSpeed is confirmed),
   then request a page and check the response headers with `curl -I` — you should
   see `x-litespeed-cache: hit` or `miss` and the `X-LiteSpeed-Tag` header on
   cacheable pages.
3. With the purger enabled, edit a node and confirm the corresponding cached page
   is dropped.

Head to [Configuration](../configuration/index.md) to tune TTL, private caching,
vary cookies, and the purge strategy.
