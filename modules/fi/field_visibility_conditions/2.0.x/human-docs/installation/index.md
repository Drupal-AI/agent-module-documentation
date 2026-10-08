# Installation

## Requirements

Field Visibility Conditions needs:

- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Conditions Helper** module (`drupal/conditions_helper`, `^1.0`), which
  provides the condition sub‑form builder and evaluator. Composer installs it
  automatically as a dependency.

There are no other third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_visibility_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Conditions Helper
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_visibility_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_visibility_conditions -y
```

Enabling it also enables the Conditions Helper dependency.

## Grant the permission

The module defines one restricted permission, **Administer field visibility
conditions**, which is required to reach the global settings page at
`/admin/config/content/field-visibility-conditions`. Grant it only to trusted
administrator roles.

Once enabled, follow the steps in the [main guide](../index.md#how-to-use-it):
enable the condition types you want on the settings page, then set conditions on
individual fields from their *Manage fields* edit forms.
