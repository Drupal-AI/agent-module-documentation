# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.1 or later**.
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.
- The optional Webform integration additionally needs the **Webform** module.

There are no other third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_nif_nie_cif -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_nif_nie_cif -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_nif_nie_cif -y
```

## Submodules

The optional **Webform** integration (`field_nif_nie_cif_webform`) adds a
`nif_nie_cif` Webform element that always auto-detects the type, validates the
control character, and stores the value in canonical form. Enable it only if you
use Webform:

```bash
drush en field_nif_nie_cif_webform -y
```

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage fields**, click
**Add field**, and look for the **NIF, NIE, CIF** field type. If it's listed, the
module is installed. Add the field, then try saving an invalid identifier (it should
be rejected) and a valid one like `12.345.678-Z` (it should save and be stored in
canonical uppercase without separators).
