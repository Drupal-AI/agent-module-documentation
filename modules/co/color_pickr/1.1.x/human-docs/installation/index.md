# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib dependencies and no third-party libraries to install separately —
  the Pickr JavaScript library ships **inside** the module.

## Install with Composer

From the project root:

```bash
composer require drupal/color_pickr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/color_pickr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_pickr -y
```

There is no configuration form to visit afterwards. The **Color pickr** field
type, widget, and formatters become available in the field UI immediately.

## Verify it worked

Go to a content type's **Manage fields** tab (for example
`/admin/structure/types/manage/article/fields`) and add a field. **Color pickr**
should appear in the field-type list. Once added, configure its widget on
**Manage form display** and its display on **Manage display** — see the
[main guide](../index.md#how-to-use-it) for the steps.
