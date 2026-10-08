# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal core's **Page Cache** module (`page_cache`) — Drupal enables it as a
  dependency when you turn on Custom Purge.
- **Drush** (version 9 or 10) for the purge queue commands.
- A working, regular **cron** run — or a scheduled job that runs the queue
  commands (see [Configuration](../configuration/index.md)) — so queued purges are
  actually processed.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_purge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_purge -y
```

## Verify it worked

After enabling, define at least one caching instance in the module's
configuration YAML and import it (see
[Configuration](../configuration/index.md)). Then open the **purge URLs form** in
the admin UI, submit a URL to purge, and confirm the cache for that URL is
cleared. For "purge everything" operations, check that your cron run (or scheduled
`drush queue:run`) is processing the queue.
