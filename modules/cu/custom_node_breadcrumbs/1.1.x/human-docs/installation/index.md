# Installation

## Requirements

Custom Node Breadcrumbs is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other contributed modules — it depends only on Drupal core (it uses core's
  Link field type and the Block system, both in core).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_node_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_node_breadcrumbs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_node_breadcrumbs -y
```

## Verify it worked

After enabling, follow the steps in
["How to use it"](../index.md#how-to-use-it): add the `field_breadcrumbs` **Link**
field (allowing multiple values) to a content type, add a few links to a node, and
place the **Custom Node Breadcrumb Block** via **Structure → Block layout**. Visit
that node — you should see your hand-defined breadcrumb trail, starting with the
site's front page as the home link.
