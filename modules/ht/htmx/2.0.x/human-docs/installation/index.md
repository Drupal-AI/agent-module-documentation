# Installation

## Requirements

htmx 2.0.x targets modern Drupal because it relies on the full HTMX integration
that ships with core:

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`). Core provides the
  `core/htmx` library and the `Drupal\Core\Htmx\Htmx` class this module builds on.
- **PHP 8.3 or newer** (`php: 8.3`). Composer will refuse to install the module on
  an older PHP.

There are no other module dependencies and no third-party Composer libraries. The
HTMX JavaScript itself comes from Drupal core — this module does not vendor or
download it.

## Install with Composer

From the project root:

```bash
composer require drupal/htmx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Composer reports a conflict, check that your site is on
Drupal 11.3+ and PHP 8.3+ first.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmx -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmx -y
```

Once enabled you can start using `create_htmx()` in Twig/PHP and managing HTMX
blocks at `/admin/structure/htmx-block` — see [the index page](../index.md).

## Upgrading from 1.5.x

2.0.x is a **major release**. The module's own `HtmxAttribute` and
`HtmxResponseHeaders` classes have been removed in favour of core's
`Drupal\Core\Htmx\Htmx`. If you have custom modules or themes that referenced those
classes, update them before upgrading. Twig templates that only call
`create_htmx()` continue to work.

## Optional submodule — htmx_debug

The module ships one submodule, **htmx_debug**, which un-minifies core's HTMX
library and enables the `debug` htmx extension so events are logged to the browser
console. Enable it while developing:

```bash
drush en htmx_debug -y
```

Leave it off (or uninstall it) in production.
