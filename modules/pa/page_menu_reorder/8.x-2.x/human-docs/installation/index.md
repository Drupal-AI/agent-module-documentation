# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contributed module dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/page_menu_reorder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_menu_reorder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_menu_reorder -y
```

## Grant the permission

Reordering navigation is privileged, so the tab is hidden until you grant the
module's permission. Under **People → Permissions**
(`/admin/people/permissions`), assign the Page Menu Reorder permission to the
roles that should be allowed to reorder menu links, and save.

## Verify it worked

Visit a page that has menu links, as a user who holds the permission. You should
see a **Reorder menu** tab. Open it, drag an item to a new position, and save —
the **Main navigation** menu order should update to match.
