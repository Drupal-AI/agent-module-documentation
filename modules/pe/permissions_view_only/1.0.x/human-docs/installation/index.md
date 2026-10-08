# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Filter Permissions** module (`filter_perms`) — this is a hard
  dependency. Permissions List (View Only) extends Filter Permissions to reuse
  its filtering UI, so it must be installed and enabled. Composer pulls it in
  automatically when you require this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permissions_view_only -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required Filter Permissions module for
you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/permissions_view_only -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissions_view_only -y
```

Enabling this module also enables Filter Permissions if it is not already on.

## Verify it worked

Log in as an administrator and go to **People** (`/admin/people`). You should see
a new tab for the read‑only permissions view sitting next to the standard
*Permissions* tab. Open it and confirm the grid renders granted permissions as
checkmarks (✓) with no checkboxes and no *Save* button.

Next, grant the view‑only permission to the roles that need it — see
[Configuration](../configuration/index.md).
