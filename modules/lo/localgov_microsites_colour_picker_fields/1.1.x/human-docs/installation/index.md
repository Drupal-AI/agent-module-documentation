# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Intended for a **LocalGov Microsites** platform (part of the LocalGov Drupal
  distribution) — that is where the colour fields it enhances live. It declares no
  hard module dependencies of its own.

Note that this is a beta release (the current version is a 1.1.x beta).

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_microsites_colour_picker_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_microsites_colour_picker_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_microsites_colour_picker_fields -y
```

## Verify it worked

Edit a microsite's design (or the relevant colour field's **Manage form display**) and
confirm that colour fields now show a colour picker instead of a plain hex text field.
