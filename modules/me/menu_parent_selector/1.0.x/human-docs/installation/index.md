# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third‑party PHP or JavaScript libraries — it needs
  only Drupal core (including the Field UI, part of a standard install).

## Install with Composer

From the project root:

```bash
composer require drupal/menu_parent_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_parent_selector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_parent_selector -y
```

## Verify it worked

Go to **Structure → Content types → *(a type)* → Manage fields → Add field** and
confirm **Menu Parent Item** appears as an available field type. Add it, enable it on
the form and display, then edit a node and check that choosing a menu and parent item
lists that parent's child links on the rendered node.
