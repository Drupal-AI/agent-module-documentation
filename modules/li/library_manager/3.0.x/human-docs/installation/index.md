# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **System** (`system`) and the **CodeMirror Editor** module
  (`codemirror_editor`), which provides the in‑browser syntax‑highlighted code
  editor. Composer pulls CodeMirror Editor in for you.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/library_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including CodeMirror Editor.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_manager -y
```

Drupal will enable CodeMirror Editor at the same time. There are no submodules.

## Upgrading from 2.x to 3.x

If you are moving from a 2.x release to 3.x, run the database updates so the module
can apply its update hook:

```bash
drush updb -y
```

## Verify it worked

1. Confirm **Library Manager** is enabled on **Extend** (`/admin/modules`).
2. Visit **Structure → Library** (`/admin/structure/library`) and confirm you can
   start a new library definition, with the CodeMirror editor rendering for the
   code fields.
3. Check that **Reports → Libraries** (`/admin/reports/libraries`) loads.

Next, review the settings and the important `libraries_path` note in
[Configuration](../configuration/index.md) before you build your first library.
