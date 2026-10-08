# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core modules **User** (`user`), **Block** (`block`), **REST** (`rest`), and
  **System** (`system` >= 8.1.0). Drupal enables these as dependencies
  automatically. The REST dependency is load‑bearing — the widget fetches its
  notifications over a REST endpoint.
- A **Bootstrap theme or equivalent CSS** in your project so the dropdown renders
  cleanly (the module's own note).

There are no third‑party Composer or PHP library requirements. Note that the
release documented here is **2.0.0‑alpha9**, an alpha.

## Install with Composer

From the project root — note the Composer package name is `notificationswidget`
(no underscore):

```bash
composer require drupal/notificationswidget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notificationswidget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The **machine name has an underscore** even though the project name does not, so
`drush en notificationswidget` fails. Use:

```bash
drush en notifications_widget -y
```

## Verify it worked

1. Visit the general settings at `/admin/config/system/notifications_widget` and
   **save the form once** — the module requires its configuration to be saved
   after installation before it behaves correctly.
2. Place the notification block (see [Configuration](../configuration/index.md))
   and log in as a user who should receive notifications. When an event is
   logged, the bell's unread badge should appear and the dropdown should list the
   activity — updating without a full page reload, thanks to the REST endpoint.
