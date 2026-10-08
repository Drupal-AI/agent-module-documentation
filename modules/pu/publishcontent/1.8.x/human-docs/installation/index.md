# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** module (`node`) — the only dependency, and always present on a
  content site. Publish Content applies to nodes only.
- Core's **Views** module is optional: enable it if you want the "Publish /
  Unpublish" toggle‑link field in a view.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/publishcontent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/publishcontent -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publishcontent -y
```

Or enable **Publish Content** from **Extend** (`/admin/modules`).

## Next steps

The module does nothing visible until you grant its permissions. Head to
**People → Permissions**, assign the publish/unpublish permissions to your
editorial roles, and adjust the settings form if you want to change the tab,
checkbox, revisioning, logging, or labels — see
[Configuration](../configuration/index.md).
