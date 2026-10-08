# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`), which is enabled on any standard site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fix_anonymous_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fix_anonymous_nodes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fix_anonymous_nodes -y
```

## Grant the permission

The reassignment form is protected by a dedicated **Fix anonymous nodes**
permission (marked as a restricted, security‑sensitive permission). At
**People → Permissions** (`/admin/people/permissions`), grant it only to a
trusted administrator role. Ordinary editors should not have it — the form can
reassign authorship across every node on the site.

## Verify it worked

Log in as a user with the permission and visit **Content → Fix Anonymous Nodes**
(`/admin/content/fix-anonymous-nodes`). You should see the reassignment form. See
[Configuration](../configuration/index.md) for how to run it safely.
