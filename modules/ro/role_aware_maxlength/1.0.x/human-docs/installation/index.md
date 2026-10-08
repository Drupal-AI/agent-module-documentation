# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **Field** (`field`) and **User** (`user`) modules, both part of a standard
  Drupal install.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/role_aware_maxlength -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_aware_maxlength -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_aware_maxlength -y
```

## Verify it worked

Open the **Manage form display** page for a bundle that has a string or text field,
click the gear icon next to the field's widget, and confirm you see a **Role-aware
character limits** section. If it is there, the module is installed — see *How to use
it* on the [overview page](../index.md) to configure the limits and attach the
constraint that enforces them.
