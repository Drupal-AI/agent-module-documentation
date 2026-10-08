# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party Composer or PHP library
  requirements. (Popup mode uses core's own AJAX dialog library, which ships with
  Drupal.)

## Install with Composer

From the project root:

```bash
composer require drupal/editablefields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editablefields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editablefields -y
```

## Grant the permission

Inline editing is gated by a permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant **Use editablefields** to the roles that
should be able to edit fields inline. A user also needs normal **update** access to
the entity (unless a field's formatter has *Bypass access check* turned on).

There is a second, administrative permission, **Administer editablefields**, which
is not required for ordinary inline editing.

## Next step

Enabling the module does nothing on its own — you must switch specific fields to
the **Editable field** formatter on their *Manage display* page. See
[Configuration](../configuration/index.md).
