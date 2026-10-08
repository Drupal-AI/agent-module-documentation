# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **User** module (`user`), which is enabled on every Drupal site.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_role_permissions -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_role_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_role_permissions -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_role_permissions
```

Then go to **People → Roles** (`/admin/people/roles`). The default operation link
beside each role should now read **"Edit permissions"** and take you straight to
that role's permissions page. There is nothing to configure — that's the entire
feature. Remember it grants no new access; the permissions page remains gated by
core's **Administer permissions**.
