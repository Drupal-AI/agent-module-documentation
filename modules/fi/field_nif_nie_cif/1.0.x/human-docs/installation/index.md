# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.
- The optional Webform integration additionally needs the **Webform** module.

There are no third-party Composer or PHP library requirements.

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

The optional **Webform** integration adds a NIF/NIE/CIF element to Webform that
auto-detects the type, validates the control character, and stores the value in
canonical form. Enable it only if you use Webform:

```bash
drush en field_nif_nie_cif_webform -y
```

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage fields**, click
**Add field**, and look for the **NIF, NIE, CIF** field type. If it's listed, the
module is installed. Add the field, then try saving an invalid identifier (it should
be rejected) and a valid one (it should save and be stored in canonical uppercase).
