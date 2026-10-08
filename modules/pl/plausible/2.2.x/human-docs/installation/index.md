# Installation

## Requirements

Plausible needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Nothing else required — it has no module dependencies and no third‑party
  libraries.

Two optional modules improve the experience if you already use them:

- **Gin** (`drupal/gin`) — lets the embedded dashboard match Gin's light/dark
  setting.
- **Markdown** (`drupal/markdown`) — renders the module's README on its help page.

You will also need a Plausible account (hosted at plausible.io or self‑hosted) and
your site added there, so you have a script URL — and, if you want the embedded
dashboard, a Plausible **shared link**.

## Install with Composer

From the project root:

```bash
composer require drupal/plausible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plausible -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plausible -y
```

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`), assign:

- **Administer Plausible configuration** — to roles that should change tracking
  settings.
- **View Plausible dashboard** — to roles that should see the embedded reports
  page (you can grant this to a non‑admin role that should view stats but not
  change config).

Next, configure the tracking snippet and visibility rules — see
[Configuration](../configuration/index.md).
