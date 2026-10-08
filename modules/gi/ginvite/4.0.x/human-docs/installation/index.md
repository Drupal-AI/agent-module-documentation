# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- The **Group** module (`drupal/group`, `^3.0`) enabled — Group invite is an
  extension of Group and does nothing without it.
- Core's **Views** module (`views`) enabled — the module ships two Views (a "My
  invitations" list and a per-group invitations list).

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ginvite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Group if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/ginvite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ginvite -y
```

Drupal enables Group and Views as dependencies if they are not already on.

Enabling the module makes the **Group Invitation** relation plugin available, but it
does not switch invitations on for any group type by itself — you install the relation
per group type. Head to [Configuration](../configuration/index.md) to enable and tune
invitations, then grant the group permissions that let managers send them.
