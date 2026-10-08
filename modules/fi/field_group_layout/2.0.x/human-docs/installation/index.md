# Installation

## Requirements

Field Group Layout builds on the Field Group module and core's layout system:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Field Group** (`field_group`) — the module it extends.
- Core's **Layout Discovery** (`layout_discovery`) — provides the actual layouts.

Both dependencies are enabled automatically when you turn on Field Group Layout.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/field_group_layout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_layout -y
```

Drupal enables Field Group and Layout Discovery along with it. Then set a field
group's format to **Layouts** on a Manage form display or Manage display tab — see
the "How to use it" section of the [overview](../index.md).

There are no submodules and no global settings page.
