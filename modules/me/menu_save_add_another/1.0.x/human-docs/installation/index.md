# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Menu UI** module (`menu_ui`) — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_save_add_another -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_save_add_another -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_save_add_another -y
```

That's all it takes — there is no configuration.

## Verify it worked

Log in as a user with the **Administer menus and menu links** permission, go to
**Structure → Menus**, edit a menu, and click **+ Add link**. On the menu link
form you should now see a **Save and Add Another** button alongside the usual
**Save** button. Saving a link should return you to the menu edit page rather than
the top‑level menu list.
