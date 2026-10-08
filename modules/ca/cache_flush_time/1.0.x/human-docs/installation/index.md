# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **System** (`system`) — always present in Drupal, and enabled automatically.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_flush_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_flush_time -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_flush_time -y
```

That is the entire setup. There is no configuration form.

## Verify it worked

Clear the cache (`drush cr`), then look for the reported last‑rebuild time — it should
reflect the moment you just cleared the cache. Because the timestamp is an operational
detail, make sure it is only visible where that is appropriate for your site.
