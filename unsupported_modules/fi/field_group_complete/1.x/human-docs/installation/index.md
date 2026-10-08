# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Field Group** module (`field_group`) — this is a hard dependency,
  since Field Group Complete annotates the groups that Field Group creates.
  Composer installs it automatically.

There are no third‑party libraries or external APIs — the completion logic is
plain JavaScript that ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_complete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_complete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_complete -y
```

Drupal will enable Field Group at the same time if it is not already on.

## Verify it worked

You need a content type that already uses Field Group tabs (or fieldsets/details)
containing required fields. Open that entity's edit form — for example add a new
node of that type. As you fill the required fields inside a group, the group's tab
should flip to a "Complete" badge once all of them are satisfied. If you have not
set up any Field Group tabs yet, do that first in **Manage form display** using
the Field Group module, then revisit the form.

To fine‑tune the badge text or styling, see
[Configuration](../configuration/index.md) — but the module works out of the box
with no changes.
