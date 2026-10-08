# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- Core's **File** module (`file`) — standard in Drupal, enabled automatically as a
  dependency.
- Drush, to run the cleanup command (or the optional form submodule for a UI
  trigger).
- **Backups** of your public files, private files, and database before you run any
  cleanup — this tool deletes files.
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_unused_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_unused_files -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_unused_files -y
```

## Submodules

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Remove Unused Files Form** | `remove_unused_files_form` | Adds a menu link/form to trigger the cleanup from the admin UI, instead of only via Drush. Enable it if you want a UI: `drush en remove_unused_files_form -y`. |
| **Remove Unused Files Link** | `remove_unused_files_link` | **Deprecated.** Uninstall it and use `remove_unused_files_form` instead. |

## Verify it worked

Confirm the Drush command is available:

```bash
drush remove_unused_files
```

On a test or staging site, run it after taking a backup, then run cron
(`drush cron`) and confirm that files with genuinely zero usage are cleaned up —
while checking that nothing still in use was removed. If you enabled the form
submodule, confirm its menu link/form appears in the admin UI.
