# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No module dependencies and no third‑party PHP or JavaScript libraries — it needs
  only Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_parent_select_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_parent_select_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_parent_select_filter -y
```

That's all it takes — the filter box is active immediately, with no required
configuration.

## Verify it worked

Add or edit a menu link at **Structure → Menus → *(a menu)* → Add link**, or open a
node's edit form with menu settings. You should see a filter text box above the
**Parent link** dropdown; typing into it narrows the list of options.
