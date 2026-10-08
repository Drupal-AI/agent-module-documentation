# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- No other modules, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_terms_and_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_terms_and_menus`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_terms_and_menus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_terms_and_menus -y
```

The taxonomy term and menu-link forms are streamlined right away — there's no
settings form to visit.

## Grant the advanced-options permission where needed

If some roles still need the original, full forms, go to **People → Permissions**
(`/admin/people/permissions`) and grant them **Use advanced menu options**. Any
role with that permission keeps the complete term and menu forms instead of the
simplified versions.
