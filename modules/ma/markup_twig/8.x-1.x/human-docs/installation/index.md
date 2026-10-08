# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Markup** module (`markup`) — Markup Twig extends its field. Composer pulls it
  in as a dependency.
- Core's **Field** module (`field`), part of a standard Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/markup_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the **Markup**
module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markup_twig -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markup_twig -y
```

Drupal enables the **Markup** module at the same time because Markup Twig depends on
it.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **Administer markup
fields** only to trusted roles (developers and site builders). Anyone with this
permission can write Twig that renders on your site.

## Verify it worked

There is no settings page. Instead, add a **Markup** field to a content type, and on
that bundle's **Manage form display** and **Manage display** the **Markup Twig**
widget and formatter should be selectable. See the
[overview](../index.md#how-to-use-it) for the full setup.
