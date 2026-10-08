# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — Drupal enables it
  automatically as a dependency when you turn on this module. (Layout Builder in
  turn relies on core's Layout Discovery.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revert_default_perm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revert_default_perm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revert_default_perm -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) — the permission that
controls the "Revert to defaults" button should now be present. Grant it only to
the roles that should be able to reset customized layouts, then confirm that a user
without it no longer sees the button when editing an entity's layout in Layout
Builder. See "How to use it" on the [overview page](../index.md) for the full flow.
