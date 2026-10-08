# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`) enabled — the only module dependency. The **Views
  UI** module is what you use to build Views over the registered tables.
- No third-party Composer or PHP libraries.
- Each table you want to register must already **exist** in the database and have a
  **primary key**. If it lives in a secondary database, that connection must be
  defined in your `settings.php` `$databases` array.

## Install with Composer

From the project root:

```bash
composer require drupal/view_custom_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/view_custom_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_custom_table -y
```

This adds the admin UI at **Structure → Views → View Custom Table**
(`/admin/structure/views/custom_table`).

## Grant permissions

The module ships four permissions; grant them at **People → Permissions**
(`/admin/people/permissions`) according to who should manage table registrations:

| Permission | Machine name | What it allows |
|------------|--------------|----------------|
| **Add custom table in views** | `add custom table in views` | Add and edit registrations, and set column relations. |
| **Remove custom table in views** | `remove custom table in views` | Delete a registration. |
| **Administer own custom table in views** | `administer own custom table in views` | Manage the tables the user created. |
| **Administer all custom table in views** | `administer all custom table in views` | Manage every registration, regardless of who created it. |

## Verify it worked

Visit `/admin/structure/views/custom_table`. You should see the (initially empty)
list of registered custom tables with an option to add one. From here, follow the
[Configuration](../configuration/index.md) guide to register your first table.
