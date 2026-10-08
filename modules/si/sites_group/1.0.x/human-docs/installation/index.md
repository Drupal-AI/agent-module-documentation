# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) and the **Form Decorator** module
  (`form_decorator`) — hard dependencies.
- **Group Node** (`gnode`) is optional, needed only if you want to relate nodes to
  Groups.

There are no third‑party PHP library requirements. This is an early release
(1.0.0‑alpha2) — pin your version and test carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/sites_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group and Form
Decorator as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sites_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_group -y
```

Enable `gnode` too if you want node‑to‑Group relations:

```bash
drush en gnode -y
```

## Configure through the Group UI

There is no dedicated settings form for this module — configuration happens in the
Group UI:

1. Create a Group type at **`/admin/group/types`**.
2. On that Group type's edit dialog, turn on the **"sites group"** behaviour.
3. Create Groups at **`/admin/group`** to represent your sites.
4. Grant the appropriate view permissions on the Group type's **Permissions** tab —
   review them carefully so content is not exposed across sites.

## Verify it worked

Create a Group type, enable "sites group" on it, and add a Group. Confirm that the
Group resolves as a site context (for example that content related to that Group is
scoped to it) as you build out your permissions.
