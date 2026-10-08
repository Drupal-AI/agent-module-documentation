# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`), enabled on any standard Drupal site.

No contributed‑module dependencies and no third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_preview_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_preview_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_preview_permissions -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and confirm the **use
node preview** permission (and per‑content‑type variants) now appear. Grant them to
a test role, then check that a user in that role can use the **Preview** button on a
node form even without full edit access. See "How to use it" on the
[overview page](../index.md).
