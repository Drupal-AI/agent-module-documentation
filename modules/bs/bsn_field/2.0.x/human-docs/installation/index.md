# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency. To add the field through the UI you will also want **Field UI**
  enabled. To use the BSN element in a form, you need the **Webform** module.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bsn_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bsn_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bsn_field -y
```

Once enabled, add a **BSN** field to an entity via Field UI, or add the **BSN**
element to a Webform — see [How to use it](../index.md#how-to-use-it). Remember
that a BSN is personal data: plan how you will restrict access to the stored
value before you start collecting it.
