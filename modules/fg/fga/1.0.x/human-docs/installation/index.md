# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Field Group** module (`field_group`) — the module's field‑group IDs are
  the basis for its anchors. Composer pulls it in for you.
- The project's documentation also lists the **Hux** module as a requirement;
  installing with `-W` (below) resolves any such dependencies automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/fga -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in Field Group (and any other required
modules).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fga -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fga -y
```

This also enables Field Group (and any other dependency) if it is not already on.

## Verify it worked

Confirm the module and Field Group are enabled with `drush pm:list
--status=enabled | grep -E 'fga|field_group'`. The anchors will not appear until
you assign IDs to your field groups and choose node types and placement — see
[Configuration](../configuration/index.md).
