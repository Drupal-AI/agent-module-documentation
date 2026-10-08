# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies — it uses only Drupal core's Form API and theming.

There are no third‑party Composer or PHP library requirements, and the project notes
"no restrictions" on use.

## Install with Composer

From the project root:

```bash
composer require drupal/fapi_collapsible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fapi_collapsible -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fapi_collapsible -y
```

That is all — the `collapsible` render element is now available to any module or theme
on the site.

## Verify it worked

Add a `collapsible` element to a form or render array in your custom code (see "How to
use it" in the [overview](../index.md)) and confirm the section renders with a header
and a body that expands and collapses. Since the module has no admin UI, there is
nothing else to check in the interface.
