# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — enabled on every standard Drupal site and
  pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

- **Optional:** the [Pathauto](https://www.drupal.org/project/pathauto) module —
  when installed, Node Keep adds a second checkbox that locks a node's URL alias
  against changes by unauthorized users.

## Install with Composer

From the project root:

```bash
composer require drupal/node_keep -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_keep -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_keep -y
```

Enabling the module adds the protection base field to every node bundle
automatically.

## Submodule

Node Keep ships one optional submodule, **Node Keep Token** (`node_keep_token`),
which exposes protected nodes as tokens. Enable it only if you need that:

```bash
drush en node_keep_token -y
```

## After enabling

Grant the Node Keep permissions to the right roles and, optionally, set
per‑content‑type defaults — see [Configuration](../configuration/index.md).
