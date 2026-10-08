# Installation

## Requirements

Field Label Plurals is deliberately lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and is enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_label_plurals -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_label_plurals -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_label_plurals -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and edit a
field that is configured to hold **more than one value**. Below the standard
**Label** box you should now see a new **"Label to use for a single value"** text
box. If it appears, the module is working — enter the singular wording, save, and
the field's label will switch between the singular and plural forms based on how
many values it holds.
