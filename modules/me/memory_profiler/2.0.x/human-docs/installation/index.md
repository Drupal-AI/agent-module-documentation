# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).

There are no other module dependencies, and no third‑party Composer or PHP
library requirements. The module sits in the **Development** package.

## Install with Composer

From the project root:

```bash
composer require drupal/memory_profiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/memory_profiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en memory_profiler -y
```

There is no configuration step — the module begins logging peak memory usage as
soon as it is enabled.

## Verify it worked

Visit a few pages, then open **Reports → Recent log messages**
(`/admin/reports/dblog`). You should see log entries recording the peak PHP
memory usage for the paths you visited. If you configured your site to log to
syslog, check there instead.

> **Remember to turn it off.** This is a diagnostic tool that adds a little
> overhead to every request. Once you have finished profiling, disable it with
> `drush pmu memory_profiler -y` — especially on production.
