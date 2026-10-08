# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements. The module sits in
the Administration package.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_fast_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_fast_edit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_fast_edit -y
```

There is no configuration step — Menu Fast Edit has no settings and makes no
database changes. It automatically affects all unlocked menu manage forms.

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`) and click **Edit menu** on a
menu that is not locked. You should now see **Title** and **URL** fields you can
edit inline on the overview, with a single **Save** button. (The locked *admin*
menu will not show them — that is expected.)
