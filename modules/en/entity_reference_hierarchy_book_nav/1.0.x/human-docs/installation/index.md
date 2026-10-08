# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The [Entity Reference (with) Hierarchy](https://www.drupal.org/project/entity_reference_hierarchy)
  module (`entity_reference_hierarchy`) — a hard dependency Composer and Drupal
  will pull in for you.
- No third‑party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_hierarchy_book_nav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Entity Reference Hierarchy
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_hierarchy_book_nav -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_hierarchy_book_nav -y
```

Drupal enables the required `entity_reference_hierarchy` module automatically as
a dependency.

## Verify it worked

After enabling, check that the **Book** and **Book chapter** content types
appear at **Structure → Content types**, and that the **Book Contents Block**
and **Book Navigation** blocks are available at **Structure → Block layout**.
Then follow the "How to use it" section of the [guide](../index.md) to configure
the Book structure field and place the blocks.
