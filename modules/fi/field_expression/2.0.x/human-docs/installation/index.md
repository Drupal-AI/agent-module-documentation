# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Token** module (`drupal/token`) — listed as a dependency and strongly
  recommended. Without it, expressions can only use hard‑coded values; with it,
  expressions can read values from other fields on the entity.

There are no other third‑party PHP library requirements in the 2.0.x line.

## Install with Composer

From the project root:

```bash
composer require drupal/field_expression -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_expression -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_expression token -y
```

This enables both Expression Field and the recommended Token module in one
command.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**
and confirm that **Expression** appears in the list of available field types. Add
one, give it a simple expression (using tokens for other fields), save a piece of
content, and check that the stored, computed value renders as expected.
