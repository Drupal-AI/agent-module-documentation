# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Search** module (`search`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Search Exclusion by Node id.
  The module filters core Search's node search, so core Search needs to be set up
  for it to do anything.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_exclude_nid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_exclude_nid -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_exclude_nid -y
```

That's all. Head to **Configuration → Search and metadata → Search Exclusion by
Node id** to add the node IDs you want to hide — see the
[overview](../index.md#how-to-use-it) for the steps.

> **Upgrading from an older version?** An update hook (`update_9001`) migrates
> any exclusion list that used to be stored in configuration into State storage
> automatically. Run `drush updatedb` after updating.
