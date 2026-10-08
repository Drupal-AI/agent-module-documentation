# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- These Drupal core modules, all enabled automatically as dependencies:
  **Node** (`node`), **Taxonomy** (`taxonomy`), **Options** (`options`),
  **Menu UI** (`menu_ui`), and **Menu Link Content** (`menu_link_content`).
- No third-party Composer libraries.

You do not need the rest of the Workbench suite — Workbench Access runs
stand-alone.

## Install with Composer

From the project root:

```bash
composer require drupal/workbench_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/workbench_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workbench_access -y
```

Enabling the module does not restrict anything yet — access control only begins
once you create an access scheme and assign editors to sections. See
[Configuration](../configuration/index.md).

## Submodule

The module ships one submodule, **`workbench_access_hooks`**, which is a *hidden,
test-only* module demonstrating an alter hook. You normally do **not** enable it on
a real site.

## Drush helpers

The module provides two handy Drush commands for testing:

- `drush workbench_access:installTest` — scaffolds a demo taxonomy vocabulary and
  field so you can try a scheme quickly.
- `drush workbench_access:flush` — clears all section assignments (useful while
  testing).

## Verify it worked

Go to **Configuration → Workflow → Workbench Access**
(`/admin/config/workflow/workbench_access`). You should see the Workbench Access
admin area with an option to **Add access scheme**. Continue with
[Configuration](../configuration/index.md) to set one up.
