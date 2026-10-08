# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Drupal core only — specifically the **Field**, **Filter**, and **Field UI**
  modules, all part of a standard install. There are no third‑party Composer
  packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/readonly_html_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readonly_html_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readonly_html_field -y
```

If **Field UI** is not already enabled (it is on most sites), turn it on too so
you can add the field through the admin UI:

```bash
drush en field_ui -y
```

## Verify it worked

Go to any content type's **Manage fields → Create a new field**. In the field type
list you should see **Readonly Html field** under the *formatted text* category.
See the [main guide](../index.md#how-to-use-it) for adding and configuring it.
