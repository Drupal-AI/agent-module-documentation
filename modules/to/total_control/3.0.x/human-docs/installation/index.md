# Installation

## Requirements

Total Control builds on Page Manager and Panels, so it has several dependencies —
Composer installs the contrib ones for you:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Contrib modules:
  - **[CTools](https://www.drupal.org/project/ctools)** `~3.0 || ~4.0` (`ctools`)
  - **[Panels](https://www.drupal.org/project/panels)** `~4.0` (`panels`)
  - **[Page Manager](https://www.drupal.org/project/page_manager)** (`page_manager`)
- Core modules (enabled automatically as dependencies): **Block** (`block`),
  **Views** (`views`), and **Contextual Links** (`contextual`).

Optional: with the core **Taxonomy** module enabled you also get a categories overview,
and with the core **Comment** module enabled you get a comments overview — Total
Control copies the needed configuration into place when those modules are on.

## Install with Composer

From the project root:

```bash
composer require drupal/total_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Page Manager, Panels,
CTools, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/total_control -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en total_control -y
```

Drupal enables the Page Manager, Panels, CTools, Block, Views, and Contextual modules
at the same time if they are not already on. On install, the module creates its
dashboard page and Views.

## Grant the permission

Total Control defines a single permission, **Have total control**, at **People →
Permissions** (`/admin/people/permissions`). It governs access to the dashboard
(`/admin/dashboard`) *and* its listing pages. Grant it to the administrator/editor
roles that should use the dashboard:

```bash
drush role:perm:add content_admin 'have total control'
```

Then visit **`/admin/dashboard`** — see
[How to use it](../index.md#how-to-use-it) for customizing it.
