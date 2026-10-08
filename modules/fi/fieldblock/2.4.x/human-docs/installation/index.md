# Installation

## Requirements

Field as Block is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — the only dependency, and Drupal enables it
  automatically when you turn on Field as Block.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fieldblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fieldblock -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fieldblock -y
```

## Verify it worked

After enabling, visit **Configuration → Field as block**
(`/admin/config/fieldblock/fieldblockconfig`). You should see a settings form
listing the entity types you can expose as field blocks. Once you enable at least
one type there and save, go to **Structure → Block layout** and click *Place
block* on any region — you should find blocks in the **Field as block** category
(for example *Content field*). Continue with [Configuration](../configuration/index.md)
to set up your first field block.
