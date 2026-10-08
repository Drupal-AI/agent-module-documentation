# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Internal Page Cache** module (`page_cache`) enabled — a hard
  dependency; this module extends it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_cache_vary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_cache_vary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable core Page Cache and this module

```bash
drush en page_cache page_cache_vary -y
```

Enabling the module activates the Vary‑aware middleware site‑wide. It does nothing
further on its own until a cache context implements `VaryCacheContextInterface` to
declare a header to vary on (a developer task).

## Verify it worked

After enabling, inspect the response headers of a cached page and confirm the
Vary‑aware middleware is in place. Once a context declares a header, that header
should appear in the response's `Vary` header, and your CDN/reverse proxy should
cache the variants correctly. If you need to revert, simply disable the module to
restore the stock core page cache.
