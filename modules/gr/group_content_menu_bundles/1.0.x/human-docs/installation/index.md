# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — used to add fields to the group
  menu‑link bundles.
- The **Menu Item Extras** module (`menu_item_extras`) — provides the fieldable
  menu‑link machinery.
- The **Group Content Menu** module (`group_content_menu`) — provides the per‑group
  menus this module makes fieldable.
- **Install before creating any content menu link** — the integration can only be
  set up on a clean group‑menu configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/group_content_menu_bundles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Menu Item Extras and Group Content Menu) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_content_menu_bundles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_content_menu_bundles -y
```

Drupal enables the Field UI, Menu Item Extras, and Group Content Menu dependencies
automatically if they aren't already on. Do this **before** creating any group
content menu links.

## Verify it worked

Open **Field UI** for a Group Content Menu type and confirm you can add fields to
it as a menu‑link bundle. Newly created group menu links should then be able to
carry those fields.
