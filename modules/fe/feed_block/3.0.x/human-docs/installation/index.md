# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **System**, **Block**, **Block Content**, **Node**, and **Link** modules
  (`system`, `block`, `block_content`, `node`, `link`) — all part of standard Drupal
  and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements, and the module adds no
permissions or config schema of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/feed_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feed_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feed_block -y
```

Enabling the module installs the **Feed Block** custom block type (with its RSS Feed,
Intro Text, and Read More fields). There is no settings page to visit — you create a
feed by adding one of these custom blocks and placing it. Head to
[Configuration](../configuration/index.md) for the walkthrough.

This module has no submodules.
