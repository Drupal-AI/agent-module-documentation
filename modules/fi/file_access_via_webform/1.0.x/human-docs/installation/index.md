# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`drupal/webform`) — a contributed dependency; Composer
  installs it for you.
- Core's **File** (`file`) module, which Drupal enables automatically.
- **Optional:** the **Bootstrap 4 Modal** module (`drupal/bootstrap4_modal`)
  enhances the download button with a polished modal dialog.

## Install with Composer

From the project root:

```bash
composer require drupal/file_access_via_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Webform
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_access_via_webform -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable File Access via Webform (Webform is enabled automatically as a dependency):

```bash
drush en file_access_via_webform -y
```

To add modal dialogs, also install and enable Bootstrap 4 Modal:

```bash
composer require drupal/bootstrap4_modal -W
drush en bootstrap4_modal -y
```

## Verify it worked

After enabling, a **Webform Download Button** formatter becomes available for file
fields (on any content type's **Manage display**), and a **File Access Download
Redirect** handler becomes available under a webform's **Settings → Handlers**.
Configure both as described in [the overview](../index.md#how-to-use-it), then test a
download end to end. If something goes wrong, check the logs at **Reports → Recent
log messages** (`/admin/reports/dblog`).
