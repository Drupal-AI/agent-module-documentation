# Installation

> **Before you install:** this module is **deprecated and unsupported**. For new
> sites, use its successor **Dynamic Links** (`drupal/dynamic_links`) instead. These
> steps are for maintaining an existing site that already relies on Dynamic front.

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **PHP 8.0 or newer** — the module requires it.
- No third‑party Composer libraries and no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_front -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_front -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_front -y
```

## Grant the permission

A dynamic front page requires the **View dynamic front** permission
(`access dynamic_front`). Go to **People → Permissions**
(`/admin/people/permissions`), grant it to the roles that should be redirected — the
project notes you typically grant it to the **authenticated user** role — and save.

## Verify it worked

After enabling, configure your candidate paths (see
[Configuration](../configuration/index.md)), then visit the site's front page as a
user who holds the permission. You should be redirected to the first configured path
you're allowed to view. If no configured path is viewable, you'll get an access‑denied
response — which is the intended behavior.
