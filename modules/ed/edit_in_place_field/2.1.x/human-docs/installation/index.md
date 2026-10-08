# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No hard third‑party dependencies. Optionally,
  [Chosen](https://www.drupal.org/project/chosen) or
  [Select2](https://www.drupal.org/project/select2) add richer select widgets for
  entity‑reference fields.
- The **"Allow to use edit in place field to save entities"** permission
  (`edit in place field editing permission`) must be granted to the roles that
  should edit inline.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_in_place_field -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_in_place_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_in_place_field -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_in_place_field
```

The module is now installed, but nothing changes on screen until you do two
things: switch a supported field to the **Edit in place** formatter on *Manage
display*, and grant the editing permission on **People → Permissions**. See the
["How to use it"](../index.md#how-to-use-it) steps in the overview.
