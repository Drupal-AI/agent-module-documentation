# Installation

## Requirements

Multiple Dates is lightweight and self‑contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.
- **No external JavaScript library** and no third‑party Composer packages — the
  calendar picker ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_dates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multiple_dates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_dates -y
```

To configure the field through the UI you will also want core's **Field UI**
module enabled (`drush en field_ui -y`) if it is not already.

## Verify it worked

Go to any bundle's **Manage fields** (for example **Structure → Content types →
Article → Manage fields**), click **Add field**, and confirm **Multiple Dates**
appears in the list of field types. Add it, then check the **Manage form display**
tab to see the widget options — that confirms the field type and its widget are
registered correctly.
