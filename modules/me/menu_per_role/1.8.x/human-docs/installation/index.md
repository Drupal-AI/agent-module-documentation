# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — the only
  dependency, enabled automatically. This is what provides the editable content
  menu links the module restricts.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_per_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_per_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_per_role -y
```

Or enable **Menu Per Role** from **Extend** (`/admin/modules`).

## Next steps

Once enabled, the role selectors appear on content menu links right away. Review
the global settings (which selectors show, behavior on node links, admin bypass)
and grant the permissions as needed — see [Configuration](../configuration/index.md).

Remember the scope limit: only **content** menu links are affected. Links defined
by Views or in a module's `*.links.menu.yml` cannot be restricted here.
