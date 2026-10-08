# Installation

## Requirements

Group Mandatory needs the Group module and Route Override:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Group** module (`group`).
- The **Route Override** module (`route_override`) — used to override the create
  form route for mandatory bundles.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_mandatory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Route Override) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_mandatory -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_mandatory -y
```

The Group and Route Override modules are enabled as dependencies if they are not
already on.

## Submodules

Group Mandatory ships a `group_mandatory_test` submodule, but it exists only for
automated tests — you do not need to enable it on a real site.

## Verify it worked

Edit a group relationship type (a group content type) and confirm a **Group
mandatory** fieldset with a **Mandatory** checkbox now appears on the form. Tick
it for a test bundle, then, as a user who belongs to no eligible group, try to
create that content: you should be blocked from the standalone form and shown the
group picker (or the "you must be a member of a group" message) instead.
