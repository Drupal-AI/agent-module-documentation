# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Menu UI** (`menu_ui`) and **Menu Link Content** (`menu_link_content`)
  modules — Drupal enables them automatically as dependencies when you turn on
  Dynamic Menu Item.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_menu_item -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_menu_item -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_menu_item -y
```

## First steps after enabling

1. Go to **`/admin/structure/menu/dynamic_menu_item`** and create the dynamic menu
   item.
2. Grant the **Edit dynamic menu item** permission under **People → Permissions** to
   the roles that should be able to assign a node to it while editing content.

## Verify it worked

Edit a node as a user who holds the permission, tick the dynamic‑menu‑item box, and
save. Confirm the dynamic menu link now points to that node — and that editing a
different node and ticking the box moves the link to the new node.
