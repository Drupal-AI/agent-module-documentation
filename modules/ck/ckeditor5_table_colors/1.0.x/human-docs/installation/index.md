# Installation

## Requirements

- **Drupal 11.0 or higher** (`core_version_requirement: ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), enabled.
- Core's **Editor** module, which provides text-format/editor support.

There are no third-party Composer packages or PHP library requirements. The
**CKEditor 5 Plugin Pack** is a recommended companion but is not required. This
module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_table_colors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_table_colors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_table_colors -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**) and confirm the Table Colors plugin settings appear when you
configure the toolbar. After setting up a palette (see
[Configuration](../configuration/index.md)), edit content with a table and check
that your colours appear in the table and cell properties dropdowns.
