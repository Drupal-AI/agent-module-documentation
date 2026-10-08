# Installation

## Requirements

Hide Node Title has no third‑party dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no Composer library or PHP extension requirements. It works with standard
content types and with content types built using Display Suite.

## Install with Composer

From the project root:

```bash
composer require drupal/hide_node_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hide_node_title -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hide_node_title -y
```

## Verify it worked

Add the **`field_hide_title`** checkbox field to a content type (see "How to use it"
on the [overview page](../index.md)), edit a node of that type, tick the box, and
save. View the node on the front end — its title should no longer be displayed,
while the rest of the content renders normally.
