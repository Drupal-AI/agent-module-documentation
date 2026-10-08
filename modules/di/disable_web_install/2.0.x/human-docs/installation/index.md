# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** (`system`) and **Update** (`update`) modules — System is always
  present, and Update supplies the Update Manager whose install flow this module
  disables (while leaving its update notifications intact).

There are no PHP library requirements. Note the project is **not covered by Drupal's
security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_web_install -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_web_install -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_web_install -y
```

That's all it takes — there is no configuration. The browser-based module/theme
install flow is disabled from now on.

## Verify it worked

As an administrator, go to **Extend** (`/admin/modules`) and look for the **Install
new module** action, and to **Appearance** (`/admin/appearance`) for **Install new
theme**. With the module enabled, that browser-based install flow should no longer be
available. Update notifications from the Update Manager should still appear as normal.

## Good practice alongside it

This module complements — but does not replace — restricting the install-related
permissions. Make sure only trusted administrators hold the permissions to install
and administer modules and themes, so the browser flow and the permissions both point
in the same direction.
