# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other modules and no third‑party libraries are required.

The module is covered by Drupal's security advisory policy and is actively
maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_extend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_extend -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_extend -y
```

> **Tip:** Because enabling this module blocks the Extend UI *for everyone*, plan
> how you'll manage modules afterwards — through Composer and `drush` in your
> deployment pipeline — before you switch it on in production.

## Verify it worked

After enabling, reload an admin page: the **Extend** link should be gone from the
toolbar. Then try visiting `/admin/modules` directly — you should get a **403
Access denied** even as an administrator. That confirms the module‑management paths
are locked.
