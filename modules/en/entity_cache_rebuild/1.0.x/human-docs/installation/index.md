# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no third‑party library requirements.

> **Note:** This project is not covered by Drupal's security advisory policy. The
> cache-rebuild action is protected by the module's permission, so grant that
> permission to trusted roles only.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_cache_rebuild -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_cache_rebuild -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_cache_rebuild -y
```

## Grant the permission

The module provides one permission: **rebuild cache for all content entity types**.
It gates both the tab and the rebuild action. Grant it under **People → Permissions**
(`/admin/people/permissions`) to the roles you trust — for example administrators
and content editors who need to self-service cache refreshes.

## Verify it worked

Log in as a user with the permission and open any content entity page (a node, for
example). A **Cache rebuild** tab should appear next to *View* and *Edit*. Click it
and confirm you see a status message and are returned to the entity.
