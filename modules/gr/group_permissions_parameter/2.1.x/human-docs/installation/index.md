# Installation

## Requirements

Group Permissions parameter builds on the Group Permissions module:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Group Permissions** module (`group_permissions`) — which itself requires
  the **Group** module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_permissions_parameter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group Permissions and Group) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_permissions_parameter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_permissions_parameter -y
```

Group Permissions (and Group) are enabled as dependencies if they are not already
on.

## Submodules

Group Permissions parameter ships no submodules.

## Verify it worked

Confirm the module is *Enabled* on the **Extend** page, and check that a
permissions **sync form** is now available under the **Groups** menu. The
parameter-driven behavior itself only takes effect once you provide a
`GroupPermissionsParameter` plugin in a custom module — see the main
[guide](../index.md) for how the rules are defined.
