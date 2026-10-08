# Installation

## Requirements

IBAN Field is lightweight. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), which is part of the standard Drupal
  install and is enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. The optional
Webform submodule additionally needs the contributed **Webform** module — but
only if you enable that submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/iban_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iban_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iban_field -y
```

Once enabled, the **IBAN Field** widget becomes available as a choice on the
*Manage form display* screen of any entity that has a text field. See
[How to use it](../index.md#how-to-use-it) in the overview.

## Submodule — Webform IBAN Field

If you collect bank details on webforms rather than entity forms, enable the
bundled submodule:

```bash
drush en webform_iban_field -y
```

It adds an IBAN element to the Webform UI and requires the contributed Webform
module. See its own documentation for details.
