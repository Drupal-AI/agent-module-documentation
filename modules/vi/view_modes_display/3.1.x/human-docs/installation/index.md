# Installation

## Requirements

View Modes Display needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Nothing else — it has no module dependencies and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/view_modes_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/view_modes_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_modes_display -y
```

## Grant the preview permission

The **Preview** tabs and links only appear for users who hold the restricted
**Preview entities in all available view modes** (`preview view modes`)
permission. At **People → Permissions** (`/admin/people/permissions`), grant it to
your trusted site‑builder / themer roles only — and read the
[security caveat](../index.md#how-to-use-it) first, because it bypasses
per‑entity view access.

There is no configuration form to visit; once the permission is granted, the
preview tabs are ready to use. See the [overview](../index.md#how-to-use-it) for
how to open a preview.
