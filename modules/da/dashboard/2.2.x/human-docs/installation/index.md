# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`). This module is
  Drupal 11 only.
- Three core modules, which Drupal enables automatically as dependencies:
  **Layout Builder** (`layout_builder`, used to build each dashboard's layout),
  **Node** (`node`) and **Views** (`views`).

There are no third‑party Composer or PHP library requirements. The module also has
optional integrations with the Gin theme, Navigation, Toolbar and Coffee that
activate on their own when those are present — none of them are required.

## Install with Composer

From the project root:

```bash
composer require drupal/dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dashboard -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dashboard -y
```

Enabling it also enables Layout Builder, Node and Views if they are not already on.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Administer dashboard** — full control: view the dashboard list, add, edit,
  delete and preview dashboards, and build their layouts. Grant this to your site
  builders.
- **Access to _\<name\>_ dashboard** — one of these is generated automatically for
  *each* dashboard you create. Grant each role the permission for the dashboard it
  should see. This is the mechanism behind per‑role dashboards.

Note that even user 1 needs the relevant "Access to … dashboard" permission to view
a dashboard — access is not automatically granted to anyone.

## Verify it worked

Visit **Structure → Dashboard** — the (initially empty) dashboard list should load.
Create a dashboard, add a block or two via **Edit layout**, grant your role access
to it, and visit **/admin/dashboard** to see it. See
[Configuration](../configuration/index.md) for the details.
