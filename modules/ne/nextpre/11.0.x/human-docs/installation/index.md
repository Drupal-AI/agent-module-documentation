# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) enabled — the only dependency, and part of Drupal core (it
  is on by default on any site that uses content).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nextpre -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nextpre -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nextpre -y
```

Once enabled, the **Next Previous link** block becomes available in **Structure → Block
layout**. There is no settings page — see the [main page](../index.md#how-to-use-it) for how
to place and configure the block.
