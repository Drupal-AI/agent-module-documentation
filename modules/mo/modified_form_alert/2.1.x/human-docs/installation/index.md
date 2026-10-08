# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 8.0** or newer.

There are no contrib module dependencies and no third‑party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/modified_form_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/modified_form_alert -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modified_form_alert -y
```

## Verify it worked

Open a form, change a field, and try to leave the page without saving. The browser
should show its native "changes you made may not be saved" confirmation prompt.
See the [main guide](../index.md) for how the alert behaves.
