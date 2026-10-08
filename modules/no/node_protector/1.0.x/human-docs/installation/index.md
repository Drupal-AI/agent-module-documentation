# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No contributed‑module dependencies and no third‑party libraries — it uses only
  core.

## Install with Composer

From the project root:

```bash
composer require drupal/node_protector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_protector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_protector -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → Node Protector**
(`/admin/config/system/node_protector/settings`). Set a protected node or enable
automatic front‑page protection (see [Configuration](../configuration/index.md)),
then try to delete that node — you should be shown a warning and redirected back
to the node instead of the delete completing.
