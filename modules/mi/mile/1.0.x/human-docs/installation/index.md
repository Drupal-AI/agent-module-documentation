# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — Drupal enables it
  automatically as a dependency when you turn on MILE. This is the only
  dependency; MILE needs nothing beyond Drupal core.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mile -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mile -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mile -y
```

## Grant the permission

MILE adds an **administer mile references** permission that controls who can attach
content to menu items. Grant it only to trusted editor/administrator roles at
**People → Permissions** (`/admin/people/permissions`), since the content those
users reference can appear in menus shown to everyone.

## Verify it worked

Edit any menu link under **Structure → Menus** (`/admin/structure/menu`). If MILE
is installed and you have the *administer mile references* permission, you'll see a
**MILE references** fieldset on the edit form. Attach a node or block, choose a
view mode, save, and check the menu on the frontend — the item should now render
the referenced content in place of the plain link. See the
[main guide](../index.md) for the full walkthrough.
