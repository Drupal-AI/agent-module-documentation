# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu UI** for the menu link forms where the feature appears (part of a
  standard Drupal install).
- No third‑party JavaScript library is needed — the search runs on the module's
  own bundled JS/CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/parent_link_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parent_link_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en parent_link_search -y
```

There is no configuration step.

## Verify it worked

Go to **Structure → Menus**, pick a menu with several links, and choose **Add
link** (or edit an existing one). Below the **Parent link** dropdown you should now
see a text field and a **Highlight** button. Type part of a menu item's name,
click **Highlight**, and the matching option should be highlighted and brought
into view.
