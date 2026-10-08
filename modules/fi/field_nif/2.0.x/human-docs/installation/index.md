# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements. The optional Webform
element is only useful if you also run the **Webform** module.

## Install with Composer

From the project root:

```bash
composer require drupal/field_nif -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_nif -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_nif -y
```

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage fields**, click
**Add field**, and look for the **NIF/CIF/NIE** field type in the list. If it's
there, the module is installed. Add the field, then try saving an invalid number —
it should be rejected — and a valid one, which should save successfully.
