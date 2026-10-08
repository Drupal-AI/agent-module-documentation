# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** (`block`), **Node** (`node`) and **System** (`system`) modules —
  Drupal enables them automatically as dependencies (Node and System are on by default;
  Block is what lets you place the updated-date block).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/updated -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/updated -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en updated -y
```

Enabling the module adds a "Display updated date" base field to all node types (default
off) and makes the "Last Updated date block" available to place.

## Grant the permission

To let editors toggle the date per node and per content type, grant **Administer node
last updated date** at **People → Permissions**, or with Drush:

```bash
drush role:perm:add content_editor 'administer node last updated date'
```

## Next step

Place and configure the block, set your per-content-type defaults, and toggle
individual nodes — see [How to use it](../index.md#how-to-use-it).

> **Uninstalling:** the module cleans up after itself — uninstalling removes the
> per-content-type default overrides it created.
