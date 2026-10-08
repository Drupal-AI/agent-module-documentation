# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block Content** (`block_content`), **Layout Builder**
  (`layout_builder`), **Options** (`options`), and **Text** (`text`) modules.
  Drupal enables these as dependencies.
- You will need at least one **custom block type** with suitable fields (heading
  text, a heading‑level Options field, and a heading‑style field) — see the
  overview's "How to use it".

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_block_headings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_block_headings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_block_headings -y
```

Drupal will enable Block Content, Layout Builder, Options, and Text as
dependencies.

## Verify it worked

Edit one of your **block types** at **Structure → Block types** and confirm the
module's heading settings now appear, letting you map a heading field, level field,
and style field. Then place a block of that type in a Layout Builder layout and
check that the managed heading renders (and, if enabled, the per‑placement level/
style overrides appear). See the overview's "How to use it".
