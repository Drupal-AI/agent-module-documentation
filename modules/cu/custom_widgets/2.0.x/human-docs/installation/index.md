# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No required module dependencies and no third‑party PHP libraries.
- **Optional:** the [Select2](https://www.drupal.org/project/select2) module — if
  it is installed and enabled, the autocomplete widget can render through Select2.
  It is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_widgets -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_widgets -y
```

## Verify it worked

Go to a content type's **Manage form display** (**Structure → Content types →
*(type)* → Manage form display**). For a List field you should now be able to
pick the **Autocomplete** widget, and for an entity‑reference‑to‑taxonomy field
the **Flat select** widget. See the "How to use it" section of the
[overview](../index.md) for configuring each widget.
