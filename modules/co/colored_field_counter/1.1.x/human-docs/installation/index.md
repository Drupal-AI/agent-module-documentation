# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).

The module declares no other module or PHP library dependencies — it builds on
Drupal core's Field system.

## Install with Composer

From the project root:

```bash
composer require drupal/colored_field_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colored_field_counter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colored_field_counter -y
```

## Verify it worked

Go to a content type's **Manage form display** and change a text field's widget — the
Colored Field Counter simple and complex widgets should appear as options. See "How to
use it" on the [overview page](../index.md) for configuring them.
