# Installation

## Requirements

Webform Submission Import is an add-on for the Webform module. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform ^6.0`), enabled.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_submission_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Webform and its
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_submission_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_submission_import -y
```

Once enabled, every webform gains an **Import Submissions** tab (visible to users with the
*Administer webform* permission). There is no configuration step — go straight to a webform's
Import Submissions tab and upload a CSV, as described in the
[overview](../index.md#how-to-use-it).

There are no submodules.
