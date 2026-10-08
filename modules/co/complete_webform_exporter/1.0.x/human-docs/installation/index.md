# Installation

## Requirements

- **Drupal 10.1, or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Webform** module (`webform`) — the only module dependency, and the
  source of the submissions you are exporting.
- **PhpSpreadsheet**, the PHP library that generates the spreadsheet inside the
  ZIP. It ships with Webform, so installing Webform through Composer pulls it in
  automatically — there is nothing extra to add by hand.

There are no other third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/complete_webform_exporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Webform and PhpSpreadsheet) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/complete_webform_exporter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en complete_webform_exporter -y
```

Enabling it also enables Webform if it is not already on.

## Grant the download permission

At **People → Permissions** (`/admin/people/permissions`), give the roles that
should be able to export the **Download any webform submission managed files**
permission. Drupal marks it security-sensitive, so grant it only to trusted
roles — see the [access note](../index.md#how-to-use-it) in the overview.

## Verify it worked

Open any webform submission under **Structure → Webforms → *(your form)* →
Results → Submissions**. As a user who holds the download permission, you should
see a download action that produces a ZIP containing the submission's
spreadsheet and its attached files. If you don't see it, confirm the permission
is granted and the cache has been rebuilt (`drush cr`).
