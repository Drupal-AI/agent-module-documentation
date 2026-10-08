# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Node** (`node`) and **User** (`user`) modules — both enabled on most
  sites already.
- **Field UI** (`field_ui`) is strongly recommended so you can configure per‑field
  hints through the admin interface.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_role_hints -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_role_hints -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_role_hints -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Field
role hints** (`/admin/config/content/field-role-hints`). You should see the global
settings form. Then edit any field (**Structure → Content types → *(type)* →
Manage fields → *(field)***) and confirm a **Field role hints** section now appears
on the field's edit form. See [Configuration](../configuration/index.md) for what
each option does.
