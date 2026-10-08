# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **Flag** module (`drupal/flag`) — Flag Anonymous is an add-on that
  extends it, so you need at least one flag configured for it to do anything.
  Composer installs Flag automatically.

There are no third-party Composer libraries and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_anon -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in the Flag module and reconcile any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flag_anon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_anon -y
```

Enabling Flag Anonymous also enables the **Flag** module if it isn't on already.

## Before you configure

Flag Anonymous adds its options to an existing flag, so you need a flag to attach
them to. If you don't already have one, create a flag first at **Structure →
Flags** (`/admin/structure/flags`) — for example a *Bookmark* or *Like* flag on
content.

## Verify it worked

Edit any flag at **Structure → Flags → (your flag)**. On the flag's edit form you
should now see an **Anonymous settings** section. That section is what Flag
Anonymous adds — see [Configuration](../configuration/index.md) for how to fill it
in and the required permission step.
