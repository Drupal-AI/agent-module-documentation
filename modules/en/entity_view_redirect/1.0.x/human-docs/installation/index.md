# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies and no third‑party Composer or PHP libraries.

The module works with the core **Node**, **Taxonomy**, and **User** entity view
pages.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_view_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_view_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_view_redirect -y
```

## Grant the permission

The module provides its own administration permission. At **People → Permissions**
(`/admin/people/permissions`), grant it to the trusted roles that should manage
redirects.

## Verify it worked

After configuring a redirect (see [Configuration](../configuration/index.md)),
visit the canonical view page of an affected entity — for example a node at
`/node/{id}` — and confirm you are sent to its edit form (or your chosen target)
instead of the rendered view page.
