# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No module dependencies and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_link -y
```

That is the entire setup. There is no configuration — once enabled, the
`calendar_link()` and `calendar_links()` Twig functions are available in your
templates. See the [main guide](../index.md) for how to call them.
