# Installation

## Requirements

- **Drupal 10.5, 11.2, or 12** (`core_version_requirement: ^10.5 || ^11.2 ||
  ^12`).
- Core's **Node**, **Media**, and **Taxonomy** modules (all standard).
- **Quick Node Clone** (`drupal/quick_node_clone`, `^1.10`) — the module clones
  nodes through it; Composer pulls it in as a dependency.

There are no other PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Quick Node Clone
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_templates -y
```

This enables `node`, `media`, `taxonomy`, and `quick_node_clone` if they are not
already on.

## What enabling installs

- A `content_template` entity type with fields for a **source node**
  (`field_source`), an optional **category** (`field_category`), and an optional
  **image** (`field_image`).
- A **template_category** taxonomy vocabulary used to group templates.
- A hidden `template` field on every node type that records which template a node
  was created from, plus a "Content Template" column/filter on the admin Content
  view.

## Next steps

Grant the right permissions and start building templates — see
[Configuration](../configuration/index.md).
