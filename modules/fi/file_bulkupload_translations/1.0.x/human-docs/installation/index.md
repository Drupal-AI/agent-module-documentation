# Installation

## Requirements

- **Drupal 11.2 or higher** (`core_version_requirement: ^11.2`).
- Core's **Content Translation** (`content_translation`), **Field UI** (`field_ui`),
  and **Media** (`media`) modules, which Drupal enables automatically as
  dependencies.
- **More than one language** configured on your site, and the target media type /
  file field set up as **translatable** — otherwise there is nothing to bulk-upload
  translations into.

There are no third-party Composer or PHP library requirements.

> **Note:** This project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/file_bulkupload_translations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_bulkupload_translations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_bulkupload_translations -y
```

## Set permissions

The module provides its own permissions. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant the bulk-upload capability to the roles that
manage multilingual media.

## Verify it worked

Confirm you have at least two languages enabled and a translatable media type. On
that media type's **Manage form display**, the module's bulk-upload widget should be
selectable for the file field. Enable it, then try uploading a couple of named files
(for example `report_en.pdf` and `rapport_fr.pdf`) and confirm the translations are
created automatically. See [the overview](../index.md#how-to-use-it) for the widget
options.
