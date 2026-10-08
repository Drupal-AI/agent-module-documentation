# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and Drupal enables it
  automatically. (Views is on by default on most sites.)

There are no third‑party Composer or PHP library requirements. Note that Views
Templates only does something useful when another module registers a template —
on its own it adds the "Add view from template" workflow but lists no templates.

## Install with Composer

From the project root:

```bash
composer require drupal/views_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_templates -y
```

This module ships **no submodules** and has no settings to configure. Access to
the template workflow uses core's **Administer views** permission.

## Verify it worked

Go to **Structure → Views** (`/admin/structure/views`). You should see a new
**Add view from template** action. Clicking it opens the template list — which
will be empty until a module that provides templates is also installed.
