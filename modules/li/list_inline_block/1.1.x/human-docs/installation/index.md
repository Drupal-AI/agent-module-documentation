# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Layout Builder** module (`layout_builder`) and its dependencies.
  Drupal enables Layout Builder as a dependency when you turn on List Inline
  Block, but since inline blocks only exist once you've been building layouts with
  Layout Builder, you'll normally already have it in use.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/list_inline_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/list_inline_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en list_inline_block -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Block layout → List Inline
Block** (`/admin/structure/block/list-inline-block`). You should see the report
listing your Layout Builder inline blocks and where they are used. If you prefer
the command line, run `drush inline-block:list <blockType>` with the machine name
of one of your inline block types and confirm it returns a list.
