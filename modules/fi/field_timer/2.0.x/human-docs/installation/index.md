# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** module (`datetime`), since the formatters target the core
  datetime field type. Drupal enables it automatically as a dependency.
- No third‑party Composer packages are required for the module itself. The
  JavaScript formatters, however, each need a front-end library placed in your
  site's `libraries/` folder — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/field_timer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_timer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_timer -y
```

## Front-end libraries (only for the JavaScript formatters)

The **Text timer or countdown** formatter needs nothing extra. The three animated
formatters each need a JavaScript library downloaded into your site's
`libraries/` directory:

| Formatter | Library | Location |
|-----------|---------|----------|
| jQuery Countdown | jQuery Countdown (v2.1.0) | `libraries/jquery.countdown` |
| jQuery Countdown LED | jQuery Countdown (v2.1.0) | `libraries/jquery.countdown` |
| County | County | `libraries/county` |

Download the appropriate library and place it so the files sit at the path shown
above, then clear caches (`drush cr`). If the library isn't present, choose the
dependency-free **Text timer or countdown** formatter instead.

Once enabled, pick a Field Timer formatter on a datetime field's **Manage
display** page — see the [overview](../index.md) for the steps and each
formatter's settings.
