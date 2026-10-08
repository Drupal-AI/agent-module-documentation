# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core's **File**, **Filter**, and **Options** modules — enabled automatically as
  dependencies.
- The **`laminas/laminas-feed`** PHP library (`^2.17`), used by the default
  parser to read feeds. Composer downloads it for you.
- A working **cron** — imports run on cron, so make sure Drupal's cron is
  scheduled (or run it manually) for feeds to refresh.

## Install with Composer

From the project root:

```bash
composer require drupal/aggregator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Installing with Composer is important here because it
pulls in the required `laminas/laminas-feed` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aggregator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aggregator -y
```

Or enable **Aggregator** from **Extend** (`/admin/modules`).

## Next steps

Add one or more feeds and grant the two permissions before content will appear —
see [Configuration](../configuration/index.md). Remember to grant **Administer
news feeds** only to trusted roles, since it lets a user point the site at
arbitrary URLs.
