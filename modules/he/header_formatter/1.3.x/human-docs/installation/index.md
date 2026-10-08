# Installation

## Requirements

Header Formatter is about as lightweight as a module gets:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core only — there are **no** other module, Composer, or PHP library
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/header_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/header_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en header_formatter -y
```

That's all. There is no settings page and no required configuration — the new
**Header** formatter is immediately available on the **Manage display** tab for
any single‑value text field. See the [main guide](../index.md) for how to apply
it.
