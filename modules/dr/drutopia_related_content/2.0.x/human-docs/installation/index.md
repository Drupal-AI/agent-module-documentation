# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Node** and **Views**.
- **Similar By Terms** (`similarterms`) — computes relatedness from shared
  taxonomy terms.
- **Block Visibility Groups** (`block_visibility_groups`) — scopes the
  related-content block.
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_related_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Similar By Terms,
Block Visibility Groups and Drutopia Core.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_related_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_related_content -y
```

This imports the `related_content` view and the related-content block placement
(via Block Visibility Groups) and enables its dependencies.

## Verify it worked

Visit a node that shares taxonomy terms with other content — the related-content
block should list those related items. You can review the view at **Structure →
Views** (`/admin/structure/views`) and the block placement at **Structure →
Block layout** (`/admin/structure/block`).
