# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).

Select a11y declares no contrib module dependencies and no PHP or third-party
library requirements — the Pidila `select-a11y` JavaScript it wraps is bundled with
the module.

## Install with Composer

From the project root:

```bash
composer require drupal/select_a11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select_a11y -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_a11y -y
```

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Select a11y for Facets** | `select_a11y_facets` | Brings the accessible multi-select widget to Facets, so faceted-search filters get the same searchable, keyboard-friendly experience. |

```bash
drush en select_a11y_facets -y
```

## Verify it worked

Go to **Manage form display** for an entity with a multi-value list or reference
field, set its widget to Select a11y, and save. Open a form that uses the field —
it should now render as a searchable, keyboard-navigable multi-select rather than a
plain multi-select box.
