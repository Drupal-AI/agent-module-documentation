# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field UI** module enabled — that is where the Manage fields screen this
  module enhances lives.

There are no other dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/required_field_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_field_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_field_display -y
```

## Verify it worked

Open any bundle's **Manage fields** screen (for example **Structure → Content
types → Article → Manage fields**). The required fields should now be marked
directly in the table. There is nothing to configure.
