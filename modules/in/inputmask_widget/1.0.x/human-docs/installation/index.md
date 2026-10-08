# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Text** module (`text`), which provides the text field type the widget
  applies to. Drupal enables it as a dependency when you turn on this module.

## Install with Composer

From the project root:

```bash
composer require drupal/inputmask_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inputmask_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inputmask_widget -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display** and
confirm the Inputmask widget is now available as a widget choice for text fields.
Set a mask on a field and add a piece of content to see it guiding input as you
type. There is no separate configuration page — the mask is set on the field
itself, as described in the [overview](../index.md).
