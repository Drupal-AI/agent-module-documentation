# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — the redirect entities this module manages. Composer pulls it in
  for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

Note that the **project (Composer) name differs from the machine name**. Require
the project `redirects_entity_manager` (plural), then enable the module
`redirect_entity_manager` (singular).

From the project root:

```bash
composer require drupal/redirects_entity_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirects_entity_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_entity_manager -y
```

## Verify it worked

Log in as a user with the **Administer redirects** permission and visit the
settings page at `/admin/config/search/redirect-entity-manager`. Choose which
entity types should show the **Redirects** tab (see
[Configuration](../configuration/index.md)), then open a node of an enabled type —
a **Redirects** tab should appear.
