# Installation

## Requirements

- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal 10.2 or newer** (`core_version_requirement: >=10.2`, i.e. `^10.2 || ^11`).
- No other contributed module dependencies and no third‑party PHP libraries.

The module acts on core's page‑caching pipeline, so for it to have any effect your
site must have a non‑zero **Browser and proxy cache maximum age** under
*Configuration → Development → Performance* (see the note below). Core's Internal
Page Cache and/or Dynamic Page Cache modules are the usual context in which this is
useful.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_control_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_control_override -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_control_override -y
```

There are **no submodules** and no permissions to grant. The module's two services
are active immediately — every applicable response now carries a `Cache-Control`
header derived from the page's real bubbled cacheability.

## Make sure core is set up to cache

The module only rewrites a header that core already produced. Confirm the site has a
page cache max‑age set (anything but zero):

```bash
drush config:get system.performance cache.page.max_age
# if it is 0, set a value, e.g. 15 minutes:
drush config:set system.performance cache.page.max_age 900 -y
```

If `cache.page.max_age` is `0`, core emits no `max-age` directive and this module
does nothing.

## Verify it worked

Make an anonymous request and look at the `Cache-Control` header:

```bash
curl -sI https://example.ddev.site/ | grep -i cache-control
```

You should see `cache-control: public, max-age=<bubbled value>` on pages whose
cacheability is not permanent, and `max-age=0` on genuinely uncacheable pages (which
are also kept out of the internal page cache).

Next, if you want to enforce a minimum or maximum advertised TTL, see
[Configuration](../configuration/index.md).
