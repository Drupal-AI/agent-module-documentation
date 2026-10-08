# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or higher**.

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The module makes no external network calls.

## Install with Composer

From the project root:

```bash
composer require drupal/dcache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dcache -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dcache -y
```

In practice you often won't enable this directly — a module that depends on DCache
will pull it in. Once enabled, its cache services (including the prebuilt
`dcache.bin.default_memory_persistent` service) become available for injection.

## Verify it worked

This is a service-only API, so there's no page to check. Confirm it's working from
code: inject `dcache.bin.default_memory_persistent` (or build a chain from
`dcache.factory`), implement a generator, and confirm `lookupOrGenerate()` returns
your value and caches it across the tiers. See the [`agent/`](../agent/start.md)
reference for details.
