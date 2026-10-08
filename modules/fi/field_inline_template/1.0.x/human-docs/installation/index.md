# Installation

## Requirements

- **Drupal 10 up to (but not including) 12** (`core_version_requirement: >=10.0 <12`).
- The **CodeMirror Editor** module (`codemirror_editor`) — provides the code
  editor used to edit the inline templates.

There are no third‑party PHP library requirements beyond that module.

> **Security coverage note.** At the documented version this module is **not
> covered by Drupal's security advisory policy**, and inline templates contain
> markup/logic — grant the configuring permission only to trusted site builders.

## Install with Composer

From the project root:

```bash
composer require drupal/field_inline_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
CodeMirror Editor dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_inline_template -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_inline_template -y
```

This also enables CodeMirror Editor if it isn't already on.

## Grant the permission carefully

The module provides a permission controlling who may configure inline templates.
Because templates can contain markup and logic, grant it **only to trusted
roles** (site builders/developers) at **People → Permissions**.

## Verify it worked

On any entity's **Manage display**, choose the inline‑template formatter for a
field — the CodeMirror editor should appear in the formatter settings. Enter a
short template, save, and view the entity to confirm your custom markup renders.
