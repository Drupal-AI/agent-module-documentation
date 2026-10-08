# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- **PHP 8.1.0+** (`^8.1.0`).
- No module dependencies and no third‑party libraries.

> **Version note:** On Drupal 11.1+ you must use Tracer 1.2 or later — Tracer 1.2
> introduced a small backward-compatibility change (see the project's change record).
> This 1.3.x line supports Drupal 11 and 12.

Tracer is normally installed automatically as a dependency of a profiling or
observability module (such as Webprofiler). You rarely install it by itself.

## Install with Composer

From the project root:

```bash
composer require drupal/tracer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tracer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tracer -y
```

Enabling it alone does nothing observable — Tracer stays in its zero-overhead no-op
mode until you activate a backend in `settings.php` (see "How to activate tracing" in
the [overview](../index.md)).

## Verify it worked

The clearest way to verify Tracer is working is through the tool that consumes it:
install and enable Webprofiler (or another module that requires Tracer), set
`$settings['tracer_plugin']` in `settings.php`, rebuild the cache, and confirm that
tool's profiler shows timing spans for a request. With no backend configured, Tracer
is intentionally silent.
