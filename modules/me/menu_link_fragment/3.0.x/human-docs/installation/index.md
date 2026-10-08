# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Menu Link Content** module (`menu_link_content`) — enabled automatically
  as a dependency when you turn this module on.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_fragment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_fragment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_fragment -y
```

## Verify it worked

Edit a menu link at **Structure → Menus → *(a menu)* → Edit link** and confirm the
new **Link fragment** field appears. Enter an anchor, save, and check that the
rendered link's URL ends with `#your-anchor`.
