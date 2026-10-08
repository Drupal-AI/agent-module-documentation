# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

There are no third-party Composer packages or PHP library requirements. The
front-end CSS/JS is bundled and loads only on pages that actually contain a
container.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_advanced_container -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_advanced_container -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_advanced_container -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**), add the container tool to the toolbar, and save. Then edit some
content, insert a container, add a couple of columns, and confirm the inline
properties toolbar and the responsive preview buttons appear. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
