# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).

There are no other module dependencies, and no third‑party Composer or PHP
library requirements. The module sits in the **Development** package.

## Install with Composer

From the project root:

```bash
composer require drupal/memory_profiler_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/memory_profiler_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en memory_profiler_plus -y
```

## Verify it worked

After enabling, visit **Configuration → Development → Memory Profiler Plus** and
make sure profiling is turned **on**. Browse a few pages, then open **Reports →
Memory Profiler Plus** — you should see rows appearing for the paths you visited,
with request counts and memory figures.

> **Remember to turn it off.** This tool records data on every request and adds
> overhead. When you finish investigating, disable profiling from the settings
> dialog, truncate the collected data there, and disable the module itself if you
> no longer need it (`drush pmu memory_profiler_plus -y`) — especially on
> production.
