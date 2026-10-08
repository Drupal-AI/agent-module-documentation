# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer (an explicit requirement of this module).
- Core **Views** (`views`) and **Node** (`node`) modules — both standard on a
  typical site, and Drupal enables them as dependencies.
- No third‑party Composer packages or external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_view_bundle_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_view_bundle_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_view_bundle_permissions -y
```

## Assign the permissions

This module has no settings form — it works through permissions. At **People →
Permissions** (`/admin/people/permissions`), assign the new *view any … in
content view* and *view own … in content view* permissions per role, one entry
per content type. See [the overview](../index.md) for how the model behaves.

## Verify it worked

Grant a test role the *view any* permission for just one content type, then log in
as a user in that role and open **Content** (`/admin/content`). The listing should
show rows of that bundle only. Confirm that a bundle the role has no permission
for does **not** appear in its listing — and remember that this filters the
listing only, not canonical pages or the API.
