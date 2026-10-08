# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No required modules outside core. The **Dashboard** module (`drupal/dashboard`) is
  suggested but optional — it is the admin dashboard the Events Feed block integrates
  with (as used in Drupal CMS).
- Outbound HTTP access to `https://www.drupal.org` so the module can fetch the events
  feed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drupical -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupical -y
```

Drupical ships no submodules. Enabling it makes the **Events Feed** block available
but does not place it anywhere — continue to [Configuration](../configuration/index.md)
to place the block, grant the **Access events** permission, and (optionally) tune the
settings.
