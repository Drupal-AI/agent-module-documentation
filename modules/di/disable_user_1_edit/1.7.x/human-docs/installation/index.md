# Installation

## Requirements

Disable user 1 edit is self‑contained. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are **no module dependencies** and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_user_1_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_user_1_edit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_user_1_edit -y
```

**Protection is active as soon as the module is enabled** — it ships with the
restriction turned on by default, so user 1 is locked immediately with no further
steps. If you ever need to make user 1 editable again, use the settings form
described in [Configuration](../configuration/index.md).

## Grant the settings permission (optional)

Only users with the **Administer disable user 1 edit** permission can reach the
settings form and toggle the protection. This is a restricted, security‑sensitive
permission — grant it sparingly at **People → Permissions**
(`/admin/people/permissions`).
