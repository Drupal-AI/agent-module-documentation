# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- File fields on the entities whose upload behavior you want to control (the module
  works with any existing file field — no special widget required).

There are no third-party Composer or PHP library requirements. Note this project is
**not covered by Drupal's security advisory policy**; review it accordingly before
production use.

## Install with Composer

From the project root:

```bash
composer require drupal/file_upload_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_upload_options -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_upload_options -y
```

## Grant the administration permission

The settings form is protected by a restricted-access permission. Grant **Administer
file upload options** to the appropriate role(s) at **People → Permissions**
(`/admin/people/permissions#module-file_upload_options`). Because this permission
governs upload behavior — which is a security boundary — give it only to trusted
administrators.

## Verify it worked

Go to **Configuration → Media → File Upload Options**
(`/admin/config/media/file-upload-options`). You should see the settings form, with
file fields listed and grouped by entity type. See
[Configuration](../configuration/index.md) for what to set there.
