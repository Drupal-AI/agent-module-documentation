# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — Drupal enables it
  automatically as a dependency. The Copy/Paste links only appear when you are editing a
  Layout Builder layout.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_copy_section -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/lb_copy_section -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_copy_section -y
```

## Grant the permission

The module's only setup is one permission, **Copy/paste sections**. Grant it to the
roles that should be able to copy and paste sections at **People → Permissions**
(`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add content_editor 'copy paste sections'
```

Grant it only to trusted content roles — it lets an editor duplicate arbitrary section
content.

## Next step

Once a role has the permission and Layout Builder is enabled for a layout, its members
see the Copy and Paste links while editing. See
[How to use it](../index.md#how-to-use-it).
