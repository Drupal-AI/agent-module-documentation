# Installation

## Requirements

Custom Checkboxes is a small theming module with no external dependencies:

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_checkboxes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_checkboxes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_checkboxes -y
```

## Verify it worked

Enabling the module makes its library available but does not change any checkboxes
by itself. Attach the library in a Twig template that renders checkboxes (see
[How to use it](../index.md#how-to-use-it)), reload a page using that template, and
the checkboxes should now render with the module's styled appearance instead of the
default browser control.
