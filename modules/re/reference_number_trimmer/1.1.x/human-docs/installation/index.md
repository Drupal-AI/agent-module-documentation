# Installation

## Requirements

Reference Number Trimmer needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Client-side **JavaScript** in the visitor's browser for the ID to be hidden — if
  JavaScript is unavailable, the field falls back to the normal autocomplete.

There are no other module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/reference_number_trimmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reference_number_trimmer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_number_trimmer -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a reference field)* → Manage
form display**. In the field's **Widget** dropdown you should now see an
autocomplete option with **"hidden IDs"** in its name. Select it, save, and edit a
piece of content — the reference field should show the label without the trailing
ID number. See the parent [guide](../index.md#how-to-use-it) for the full steps.
