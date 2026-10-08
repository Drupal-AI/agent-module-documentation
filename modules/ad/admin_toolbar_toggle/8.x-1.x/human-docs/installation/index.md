# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`), which Drupal enables automatically as a
  dependency when you turn this module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_toggle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar_toggle -y
```

## Grant the permission (optional)

The module adds one permission, `administer admin toolbar toggle settings`, which
controls access to its own settings. On **People → Permissions**
(`/admin/people/permissions`), grant it to the roles that should be able to
manage the toggle. It is safe to grant to any role that already sees the toolbar.
Everyday use of the toggle just needs the keyboard shortcut — no special
permission beyond being able to see the toolbar.
