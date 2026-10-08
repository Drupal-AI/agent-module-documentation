# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- For the optional submodules: a working **Memcache** setup with the Memcache
  module (for `pcb_memcache`), or a working **Redis** setup with the Redis module
  (for `pcb_redis`).

There are no third-party Composer requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/pcb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pcb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pcb -y
```

Enabling the module alone changes nothing — no bin becomes permanent until you
point it at pcb's backend, as described in
[Configuration](../configuration/index.md).

## Optional submodules

Enable one of these only if you want the permanent bin backed by Memcache or
Redis instead of the database:

| Submodule | Machine name | Backend service it adds |
|-----------|--------------|-------------------------|
| **PCB Memcache** | `pcb_memcache` | `cache.backend.permanent_memcache` (needs the Memcache module) |
| **PCB Redis** | `pcb_redis` | `cache.backend.permanent_redis` (needs the Redis module) |

```bash
drush en pcb_memcache -y   # or: drush en pcb_redis -y
```

## Verify it worked

Make a bin permanent (see [Configuration](../configuration/index.md)), then run
`drush pcb-list` — the bin should be listed as using a permanent backend. Warm it
with some data, run `drush cr`, and confirm the data is still there.
