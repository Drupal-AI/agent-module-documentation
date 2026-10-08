# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies. The module bundles the **evo-calendar** JavaScript library it
  needs.
- To make use of it you will write a little code (typically a custom block
  plugin) — see "How to use it" on the [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/flexible_event_calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flexible_event_calendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_event_calendar -y
```

## Verify it worked

There is no admin page to check. The module is working once you can use its
`flexible_event_calendar` render element from code (for example in a custom block)
and see the calendar render on the page where you place that block. See "How to
use it" on the [overview page](../index.md) for the render-array shape.
