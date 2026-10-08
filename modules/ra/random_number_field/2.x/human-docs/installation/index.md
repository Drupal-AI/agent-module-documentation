# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries are required. The
  field builds on core's Field API.

## Install with Composer

From the project root:

```bash
composer require drupal/random_number_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/random_number_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en random_number_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
**Random Number Field** should appear in the list of available field types. Add
it with a small min/max range, create a new piece of content, and confirm the
field is filled with a random number inside your range.
