# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11 || ^12`) — the widest core range among these tools.
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_cleanup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_cleanup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_cleanup -y
```

## Verify it worked

Log in as a user with the **Delete transient module data** permission and go to
**Configuration → System → Delete transient module data**
(`/admin/config/system/delete-transient-module-data`). You should see the list of
uninstalled or deleted modules that still have leftover data. **Take a database
backup before deleting anything**, then review the list and remove only the entries
you are sure about.
