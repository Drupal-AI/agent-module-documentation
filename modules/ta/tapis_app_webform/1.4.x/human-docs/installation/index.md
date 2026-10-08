# Installation

## Requirements

Tapis App Webform needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Webform** (`webform`) and **Webform UI** (`webform_ui`).

In practice you also want the rest of the TAPIS suite (Tenant, Auth, System, and
**TAPIS Apps**) installed, since this module exists to build the input form for a
TAPIS app and its **Launch** tab submits a TAPIS job. Composer resolves the
declared dependencies for you. There are no extra PHP or third-party library
requirements. Note this release is a beta (version 1.4.1-beta), so treat it
accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_app_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and the
other dependencies as needed. (The Composer package name,
`drupal/tapis_app_webform`, matches the module's machine name,
`tapis_app_webform`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_app_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_app_webform -y
```

## Verify it worked

Create a TAPIS app with the input type **Form**. A Webform with the same name as
the app should appear automatically — that confirms the integration is working.
From there, follow the steps in the main guide to add OSP elements and launch a
job.
