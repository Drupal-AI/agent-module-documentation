# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required, and there are no third‑party PHP libraries to
  install.

This is a developer utility, so the only real "requirement" is that you have custom
code (a module, a controller, a service) that will call its parser.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_parser_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_parser_php -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_parser_php -y
```

## Verify it worked

There is no visible change in the admin UI — this is a library. Confirm it is
enabled at **Extend** (`/admin/modules`), or with `drush pm:list --status=enabled |
grep menu_parser_php`. From there, call the parser from your own PHP code as
described in the project's developer documentation.
