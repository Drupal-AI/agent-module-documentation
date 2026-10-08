# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **[Access Unpublished](https://www.drupal.org/project/access_unpublished)**
  (`access_unpublished`) — provides the token entity and the token manager this
  module defers to for authorization.
- **[Linkit](https://www.drupal.org/project/linkit)** (`linkit`) — authors the
  `data-entity-uuid` links that this module rewrites.
- Optionally, the **embed_block** module — if present, embedded custom blocks
  render their latest revision during a preview.

Composer pulls the required dependencies in.

## Install with Composer

From the project root:

```bash
composer require drupal/access_unpublished_linked_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_unpublished_linked_nodes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_unpublished_linked_nodes -y
```

Enabling the module is not enough on its own — you must also switch on its text
filter and choose which content types to process. See
[Configuration](../configuration/index.md).
