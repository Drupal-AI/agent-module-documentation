# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).

There are no other Drupal module dependencies for the base features. The
**HTMX-powered views** feature builds on Views and Search API, and uses a small
amount of AlpineJS (bundled) for browser URL-history updates; for its pager to work
correctly you currently also need the patch from
[facets issue #3008615](https://www.drupal.org/project/facets/issues/3008615).

## Install with Composer

From the project root:

```bash
composer require drupal/htmx_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmx_extras -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmx_extras -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/structure/htmx-view`** — you should
reach the HTMX views listing (grant the `administer htmx_view` permission to any
non-admin role that needs it). To exercise lazy loading, add one of the render
helpers (`HtmxEntityPartial` / `HtmxRoutePartial`) in your own code and confirm the
content loads on demand. See [the overview](../index.md#how-to-use-it) for the
code and HTMX-view setup steps.
