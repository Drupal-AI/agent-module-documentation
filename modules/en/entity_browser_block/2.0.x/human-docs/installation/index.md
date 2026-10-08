# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** module (`block`), enabled by default.
- **Entity Browser** (`drupal/entity_browser`, `^2.12`) — a required dependency.
  Composer installs it automatically, and you must have at least one Entity
  Browser configured for this module to produce any blocks.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Entity Browser
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_browser_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_block -y
```

## Verify it worked

First make sure at least one Entity Browser exists (**Configuration → Content
authoring → Entity browsers**). Then go to **Structure → Block layout → Place
block** (`/admin/structure/block`) and look in the block chooser — you should see
a block named after each of your Entity Browsers. If none appear, confirm you
have at least one Entity Browser configured, since the blocks are derived from
them. See [How to use it](../index.md#how-to-use-it) for placing and configuring
a block.
