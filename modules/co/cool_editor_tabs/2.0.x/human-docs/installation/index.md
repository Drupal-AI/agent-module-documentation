# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11.1`). This is a
  deliberately tight requirement — the module will not install on Drupal 11.0 or
  earlier.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cool_editor_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cool_editor_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cool_editor_tabs -y
```

## Grant the permission

The restyled tabs only appear for authenticated users who hold the **`use cool
editor tabs`** permission. Go to **People → Permissions**
(`/admin/people/permissions`), find **Use Cool Editor Tabs**, and grant it to the
roles that should see the new tab interface (for example, editors and
administrators).

## Verify it worked

Log in as a user with the permission and visit any content page you can edit. You
should see a toggle button at a fixed position on the screen; clicking it reveals
the View / Edit / Revisions / Delete tabs as icon‑based buttons. If you want to
adjust the colors, see [Configuration](../configuration/index.md).
