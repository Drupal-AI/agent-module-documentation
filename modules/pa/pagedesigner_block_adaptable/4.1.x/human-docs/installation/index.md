# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) — install and enable it first; this add‑on depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_block_adaptable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_block_adaptable -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_block_adaptable -y
```

## Verify it worked

Edit content that uses Pagedesigner and place a block element — the per‑element
output‑customisation options this module provides should now be available in the
editor.
