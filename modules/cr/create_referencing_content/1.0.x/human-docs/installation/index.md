# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Three contributed modules, all installed automatically as dependencies:
  - **Entity Prepopulate (EPP)** (`epp`) — seeds the reference field from the URL.
  - **Extra Field Plus** (`extra_field_plus`) — used behind the scenes to provide the
    extra field with settings.
  - **Extra Field Configuration** (`extra_field_configuration`) — the admin UI for
    configuring extra fields.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root — note this module is an alpha release, so request it explicitly:

```bash
composer require 'drupal/create_referencing_content:^1.0@alpha' -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in EPP, Extra Field Plus,
Extra Field Configuration, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require 'drupal/create_referencing_content:^1.0@alpha' -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en create_referencing_content -y
```

Its dependencies (EPP, Extra Field Plus, Extra Field Configuration) are enabled at the
same time.

## Verify it worked

1. Confirm the module and its three dependencies appear at **Extend**
   (`/admin/modules`).
2. Follow "How to use it" in the [overview](../index.md): add a "Create Referencing
   Content button" extra field to a referenced content type, configure the button label
   and target field on that type's **Manage display**, and grant the module's
   permission.
3. View a piece of the referenced content — the button should appear, and clicking it
   should open a create form with the back-reference already filled in.
