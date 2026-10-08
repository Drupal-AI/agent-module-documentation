# Installation

Installing Memcache is a little different from a typical module: the module code
is the easy part, but it only works if the **server** is prepared first. Do the
requirements below before you expect any caching to happen.

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- A **running memcached daemon** that Drupal can reach — commonly on
  `127.0.0.1:11211` for a single-server site, or one or more dedicated memcached
  hosts for a cluster. In DDEV you can add memcached as a service; on production
  it is usually installed and managed at the OS level.
- **One of the PHP PECL extensions** installed and loaded in PHP: `memcache`
  **or** `memcached`. The module works with either; if both are present you can
  force a choice in `settings.php`. Without one of these extensions the module has
  nothing to talk to.
- No hard module dependencies and no third‑party Composer libraries.

You can confirm the PHP extension is loaded with `php -m | grep -i memcache`
(inside the container if you use DDEV).

## Install with Composer

From the project root:

```bash
composer require drupal/memcache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/memcache -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en memcache -y
```

Enabling the module registers the memcache cache backend service, but it does
**not** switch Drupal over to it automatically. You must add the `settings.php`
configuration next — see [Configuration](../configuration/index.md) — to actually
route caches to memcached.

## Submodule — Memcache Admin

Memcache ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Memcache Admin** | `memcache_admin` | A statistics report at **Reports → Memcache** (`/admin/reports/memcache`) showing live memcached data — connection status, hit/miss ratios, memory slabs, and per-server details. Handy for confirming caching is actually working and for tuning. |

Enable it when you want that visibility:

```bash
drush en memcache_admin -y
```

## Verify it worked

After adding the `settings.php` configuration, clear caches and confirm the
backend is active. If you enabled Memcache Admin, visit
**Reports → Memcache** (`/admin/reports/memcache`) — a healthy connection to the
daemon there confirms Drupal is caching in memcached rather than the database.
