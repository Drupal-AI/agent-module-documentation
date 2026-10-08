# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`).
- The **Group Content Menu** module (`group_content_menu`) — this module
  configures default links for the menus it provides.

## Install with Composer

From the project root:

```bash
composer require drupal/group_content_default_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_content_default_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_content_default_menu -y
```

Drupal enables the Group and Group Content Menu dependencies automatically if they
aren't already on.

## Grant permissions

This module provides the **Administer group content default menu** permission.
Grant it to the roles that should manage default group menus at **People →
Permissions** (`/admin/people/permissions`).

## Verify it worked

Configure a default menu for a group type (see the "How to use it" steps in the
[overview](../index.md)), then create a new group of that type. Its menu should be
auto‑populated with the default links you defined.
