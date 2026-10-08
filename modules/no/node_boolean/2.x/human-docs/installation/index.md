# Installation

## Requirements

Node Boolean is deliberately lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module, which is enabled on any standard Drupal site.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_boolean -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_boolean -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_boolean -y
```

## Verify it worked

Go to **Structure → Block layout**, edit any block, and open its **Visibility**
section. You should now see **Node Boolean** listed as one of the visibility
conditions. Select it and confirm your node's boolean field(s) appear in the
options. See the [overview](../index.md) for how to configure the condition on a
block.
