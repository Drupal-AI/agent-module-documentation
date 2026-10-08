# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).

There are no other module dependencies and no third‑party PHP library
requirements — the module ships its own lightweight JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/progresscirclebar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/progresscirclebar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en progresscirclebar -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field** and
confirm that **Progress Circle/Bar** appears in the list of field types. From
there, follow the [main guide](../index.md#how-to-use-it) to add the field, enter
a value, and pick the circle or bar display.
