# Installation

## Requirements

Group FolderShare bridges two modules, so both must be present:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`).
- The **FolderShare** module (`foldershare`) — the file/folder management module
  whose items this module auto-creates.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_foldershare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_foldershare -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_foldershare -y
```

Make sure FolderShare and Group are enabled too — Composer will have installed
them, and Drupal will enable Group and FolderShare as dependencies.

## Submodules

Group FolderShare ships no submodules.

## Verify it worked

After enabling, go to a group type's **Content** tab (**Groups → Group types →
*(your group type)* → Content**) and confirm the **Group Foldershare** plugin is
available to install. Once installed, create a new group of that type and check
that a FolderShare folder was automatically created for it in the root directory.
