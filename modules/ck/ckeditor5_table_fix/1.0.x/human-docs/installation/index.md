# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

There are no third-party Composer packages or PHP library requirements, and no
contrib dependencies. This module is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_table_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_table_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_table_fix -y
```

## Set it up per text format

Enabling the module is not enough on its own — for each CKEditor 5 text format
you must **disable core's Table plugin** and add the **Table Fix Dummy** button
in its place. See the [main guide](../index.md#how-to-use-it) for the exact
steps.

## Verify it worked

Edit content using a format you have configured this way, insert a table with a
footer row or a caption, save, and confirm the `<tfoot>`/`<caption>` markup is
preserved rather than stripped. The project page includes sample table markup you
can paste in to test the full range of structural elements.
