# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Custom Menu Links** (`menu_link_content`) and **Menu UI** (`menu_ui`)
  modules — Drupal enables both automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_item_role_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_item_role_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_item_role_access -y
```

Enabling the module adds the roles field to every menu link's edit form
immediately. There is no required configuration — you can start restricting links
right away.

## Verify it worked

Go to **Structure → Menus**, edit any menu link, and confirm you see a new roles
checkboxes field on the form. Tick a role, save, and the link will only render for
users in that role.
