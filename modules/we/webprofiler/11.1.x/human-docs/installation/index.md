# Installation

## Requirements

WebProfiler has more dependencies than most modules because it leans on Symfony's
profiler components:

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer**.
- The **Devel** (`devel`, `^5.0`) and **Tracer** (`tracer`, `^1.2`) modules —
  both required and pulled in by Composer.
- Several third-party PHP libraries, installed automatically by Composer:
  `league/commonmark`, `nikic/php-parser`, `scrivo/highlight.php`,
  `symfony/stopwatch`, and `symfony/var-dumper`.

Because it is a development tool, install it as a **dev dependency** so it does
not ship to production.

## Install with Composer

From the project root:

```bash
composer require --dev drupal/webprofiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Devel, Tracer and
the required libraries and update any shared dependencies. Using `--dev` keeps it
out of your production build.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/webprofiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webprofiler -y
```

Drupal enables the required Devel and Tracer modules automatically. The module
ships no submodules.

Remember this is a **development-only** tool — enable it on local/dev
environments, never in production. After enabling, grant the profiler permissions
and tune the settings — see [Configuration](../configuration/index.md).
