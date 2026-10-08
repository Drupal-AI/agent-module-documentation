# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- Core **Node** (`node`), **Taxonomy** (`taxonomy`), and **User** (`user`)
  modules — all standard on a typical site, and Drupal enables them as
  dependencies.
- No third‑party Composer packages or external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_view_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_view_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_view_access -y
```

## Grant the admin permission

The module ships an administration permission for opening its settings form. At
**People → Permissions** (`/admin/people/permissions`), grant it to a trusted
administrator role.

> **Heads‑up — permission name mismatch.** The settings route requires a
> permission named `administer content view access`, but the module declares the
> permission as **`administer bundle access`**. Because these machine names do not
> match, the settings form is reachable only by **user 1** until the mismatch is
> fixed in the module's code. If an administrator you granted the permission to
> still gets *Access denied* on the settings page, this is why.

## Verify it worked

As user 1 (or once the permission mismatch is resolved, as the granted admin
role), open **Configuration → People → Content View Access**
(`/admin/config/people/content-view-access`). You should see a grid of your
content types and vocabularies with a per‑role action selector. Set one bundle to
**403** for the *Anonymous* role, save, and confirm an anonymous visitor gets
*Access denied* on that content type's canonical page — while remembering the
content is still reachable via other channels (see
[Configuration](../configuration/index.md)).
