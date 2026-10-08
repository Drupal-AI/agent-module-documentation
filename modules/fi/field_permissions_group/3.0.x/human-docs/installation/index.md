# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Field Permissions** (`field_permissions`).
- **Group** (`group`) — this 3.x branch targets **Group 3**.

Composer pulls the two module dependencies in for you when you require this project.

> **Choosing a branch:** branch **3.x** supports Group 3 on Drupal 10/11; branch 2.x
> supports Group 2 on Drupal 9/10/11; branch 1.x supports Group 1 on Drupal 9/10.
> This guide covers 3.x.

## Install with Composer

From the project root:

```bash
composer require drupal/field_permissions_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here that includes Field Permissions and Group.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_permissions_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_permissions_group -y
```

Enabling this module also enables **Field Permissions** and **Group** if they are
not already on.

## Verify it worked

Edit a field on a group or group-content entity and open its **Field settings**. In
the **Field visibility and permissions** section provided by Field Permissions, you
should now see a **group-based** permission option — that is the type this module
adds. Choose it, then grant the resulting field permissions to your group roles at
the group type's **Manage permissions** screen. See
[How access is configured](../index.md#how-access-is-configured) for the full flow.
