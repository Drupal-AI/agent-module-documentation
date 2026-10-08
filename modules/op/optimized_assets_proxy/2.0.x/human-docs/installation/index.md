# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- No other module dependencies, and no extra PHP library requirements.
- Core CSS/JS **aggregation** enabled (under **Configuration → Development →
  Performance**) so there are optimized assets for the module to store and restore.

## Install with Composer

From the project root:

```bash
composer require drupal/optimized_assets_proxy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optimized_assets_proxy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optimized_assets_proxy -y
```

The module starts storing and restoring aggregates immediately — there is no
configuration step.

## Verify it worked

With CSS/JS aggregation enabled, load a page so Drupal generates its aggregate
files. As a simple check, delete an aggregate file from the `files/` directory and
request it again in the browser — the module should transparently restore it to disk
and serve it, rather than returning a 404. On a multi‑server setup you can confirm
the same behaviour on a node that never generated the file itself.
