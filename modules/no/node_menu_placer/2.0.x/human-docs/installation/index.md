# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Menu Link Weight** module (`drupal/menu_link_weight`) — this is a hard
  dependency; Node Menu Placer works together with it to update the node form's
  menu settings.
- Core's **Menu UI** must be in use so nodes can be placed in menus.

No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_menu_placer -W
```

The `-W` (`--with-all-dependencies`) flag pulls in **Menu Link Weight** and any
other shared dependencies automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_menu_placer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_menu_placer -y
```

Drupal enables **Menu Link Weight** at the same time because it is a dependency.

## Verify it worked

Make sure a content type has one or more menus available in its **Menu settings**,
then edit a node of that type. In the node form's menu settings section you should
see **Move to** buttons in place of the standard "Parent link" dropdown. If you do,
the module is working — see "How to use it" on the [overview page](../index.md).
