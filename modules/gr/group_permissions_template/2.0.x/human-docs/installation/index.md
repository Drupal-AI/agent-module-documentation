# Installation

## Requirements

Group Permissions Template builds on Group and Group Permissions:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Group** module (`group`).
- The **Group Permissions** module (`group_permissions`).

This 2.x release is meant for Drupal 10/11 with Group 2.x/3.x and Group
Permissions 2.x. There are no third‑party Composer or PHP library requirements.

## Install with Composer

Install the dependencies and this module. From the project root:

```bash
composer require drupal/group_permissions_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group and Group Permissions) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_permissions_template -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Group, then Group Permissions, then this module (Composer and Drush will
handle the dependency order for you):

```bash
drush en group_permissions_template -y
```

Group and Group Permissions are enabled as dependencies if they are not already
on.

## Submodules

Group Permissions Template ships no submodules.

## Verify it worked

Confirm you can reach the template admin page at
`/admin/group/group_permissions_template`, and that a **Permission Templates**
field is available to enable on a group type's **Manage form display**. Then
follow [Configuration](../configuration/index.md).
