# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core only — no other module dependencies and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/field_readonly_by_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_readonly_by_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_readonly_by_role -y
```

## Set the permissions

The module provides its own permissions — review them at **People → Permissions**
(`/admin/people/permissions`) and grant the ability to configure read-only rules to
the roles that manage your content model.

## Verify it worked

Go to a field's configuration (**Structure → Content types → *(type)* → Manage
fields → *(a field)***). You should see **Field Read-Only by Role** settings where
you can pick which roles may edit the field. Configure a field, then open an entity's
edit form as a user in a non-editing role — the field should appear but be greyed
out / disabled. See [Configuration](../configuration/index.md), and be sure to read
the security limitation there before relying on it.
