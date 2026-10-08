# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other module dependencies.
- To have formatter‑level cache rules respected for **anonymous** users, be aware
  you may need to disable core's internal Page Cache / Dynamic Page Cache and use
  an external cache (Varnish, Cloudflare, etc.) — see the
  [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/field_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_cache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_cache -y
```

## Verify it worked

Go to any bundle's **Manage display**, open a field's formatter settings (the gear
icon), and you should see the cache controls (max‑age, contexts, tags) that Field
Cache adds. See the [overview](../index.md#how-to-use-it) for how to set them
safely.
