# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No module dependencies, and no third-party PHP or JavaScript libraries.

> **Heads-up:** this is an **alpha** release and is **not** covered by Drupal's
> security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_lru_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_lru_cache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_lru_cache -y
```

With the default settings, the LRU cache now applies to **CLI processes only** —
Drush and other command-line batch work — and normal web requests keep using
Drupal's standard entity memory cache.

## Configure the cache (optional)

The cache is tuned through container parameters, not an admin form. Add the
following to a `services.yml` (for example your site's
`sites/default/services.yml`), adjusting the values as needed:

```yaml
parameters:
  lru_memory_cache_slots: 300
  # Valid values are: cli, on, off
  lru_mode: cli
```

- **`lru_memory_cache_slots`** sets how many entities are kept in memory before the
  least-recently-used ones are evicted (default `300`).
- **`lru_mode`** sets where the LRU cache is active — `cli` (default), `on`
  (everywhere), or `off`.

Rebuild the cache so the new container parameters take effect:

```bash
drush cr
```

## Verify it worked

Confirm the module is enabled (`drush pml --status=enabled | grep entity_lru_cache`).
Long-running CLI tasks that previously grew in memory while loading many entities
should now stay bounded once the cache is active.
