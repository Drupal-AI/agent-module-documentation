# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/add_to_head -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_to_head -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_to_head -y
```

There are no submodules.

## Grant the permission — carefully

The module's single permission, *Administer add to head*, lets whoever holds it
inject arbitrary markup and JavaScript into every page. It is flagged
security-sensitive for that reason. Grant it only to fully trusted roles, at
**People → Permissions** (`/admin/people/permissions`):

```bash
drush role:perm:add administrator 'administer add to head'
```

## Verify it worked

Visit **Configuration → Development → Add To Head**
(`/admin/config/development/add-to-head`). You should see the (initially empty)
profiles overview with an **Add** button. See
[Configuration](../configuration/index.md) to create your first profile.
