# Installation

## Requirements

Custom cache is lightweight and has no third‑party dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP extensions
  beyond what core already needs.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_cache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_cache -y
```

## Configure it in settings.php

Enabling the module alone does nothing — the backend only takes effect once you
assign it to cache bins in `settings.php`. Set `custom_cache_melt_time`, point the
bins you want capped at `cache.backend.custom_cache`, and optionally list
`custom_cache_exclude_cids`. See
[How to use it](../index.md#how-to-use-it) for the exact snippets.

## Verify it worked

After editing `settings.php`, rebuild caches with `drush cr`. From then on, items
in the bins you reassigned will expire after `custom_cache_melt_time` seconds even
if nothing invalidates them — so a stale, never‑invalidated item clears itself
within that window rather than lingering until the next manual cache clear.
