# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — enabled automatically as a dependency when you
  turn this module on. You'll also need at least one View whose results you want to
  count.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_view_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_view_count -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_view_count -y
```

## Verify it worked

Edit a menu link at **Structure → Menus → *(a menu)* → Edit link** and confirm a
new **View count** section appears. Select a View and display, save, and check that
the menu link now renders with the result count appended to its title.
