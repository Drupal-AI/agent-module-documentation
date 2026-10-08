# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Webform** module (`webform`).
- The **Webform Views** module (`webform_views`) — this module extends its
  submission-to-entity join.
- Core's **Views** module (part of Drupal core).

There are no third-party Composer or PHP library requirements, but you must install
Webform and Webform Views yourself if they are not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_views_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Webform Views is not yet in your project, add it too:

```bash
composer require drupal/webform_views drupal/webform_views_extras -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_views_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_views_extras -y
```

Webform, Webform Views and Views are required and must be enabled (Drush will
enable them as dependencies if they are installed). On install the module
back-fills the new base fields for existing submissions. There is no settings page
— register your relationships at **Structure → Webform submission relationships**,
as described in the [overview](../index.md).
