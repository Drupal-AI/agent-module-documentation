# Installation

## Requirements

Bulk Edit Terms is self-contained. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** and **Taxonomy** functionality (the action operates on nodes and
  their taxonomy-term reference fields).

There are no third-party Composer or PHP library requirements and no extra
contributed-module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_edit_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_edit_terms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_edit_terms -y
```

Once enabled, the *"Update term references for the selected content"* action is
available in the **Action** dropdown on **Content** (`/admin/content`) for any user
with the **Administer nodes** permission. See
[Configuration](../configuration/index.md) for the widget-type setting and the
permissions involved.
