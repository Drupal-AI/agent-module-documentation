# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Block Content** module (`block_content`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Block Access.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_access -y
```

Drush enables Block Content automatically if it is not already on. There is no
configuration form — once the module is active, its per‑type permissions appear
on **People → Permissions**, ready to grant. See
[Configuration](../configuration/index.md).

## Submodules

Block Access ships no submodules.
