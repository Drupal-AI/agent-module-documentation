# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No contributed‑module dependencies and no third‑party libraries — it uses only
  core.

It works well alongside **Content Translation** and **Content Moderation** if you
use them, but neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_revision_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_revision_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_revision_limit -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring → Node
Revision Limit** (`/admin/config/content/node_revision_limit`). If the settings
form loads, the module is active. Set your limits (see
[Configuration](../configuration/index.md)) — pruning then happens automatically
the next time each node is updated.
