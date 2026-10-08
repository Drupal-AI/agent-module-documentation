# Installation

## Requirements

Corresponding Entity References needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

That is it — the module declares no other module or third-party library dependencies. In
practice you will want at least two entity-reference fields (or one self-referencing field)
in place before a preset can do anything useful, since a preset pairs up existing fields.

## Install with Composer

From the project root:

```bash
composer require drupal/cer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cer -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cer -y
```

## Grant the permission

Managing presets requires the **Administer Corresponding Entity References**
(`administer cer`) permission. Grant it to a trusted role at
**People → Permissions** (`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add site_manager 'administer cer'
```

Note this permission only controls *who can manage presets*. The actual reference syncing
runs on every entity save for everyone — what limits it is ordinary entity/field access on
the corresponding entity.

## Next step

CER does nothing until you create at least one preset — see
[Configuration](../configuration/index.md).
