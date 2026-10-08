# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs Menu Anchor.

There are no third-party Composer or PHP library requirements. Note this release
is an early (alpha) version and under active development.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_menu_anchor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_menu_anchor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_menu_anchor -y
```

Enabling the module makes the **Paragraph Anchor** field type, its widget and
formatter, and the **Paragraphs Anchor Menu** block available. It does not wire
anything up automatically — see the post-install steps below.

## After enabling

To actually get a jump menu on a page, complete the setup steps described in "How
to use it" on the [overview page](../index.md):

1. Add the **Paragraph Anchor** field (`field_pma_anchor`) to each paragraph type
   that should appear in the menu (**Manage fields**).
2. Set that field's formatter to **Anchor (hidden — used by block)** in **Manage
   display**.
3. Place the **Paragraphs Anchor Menu** block in a region and set its header CSS
   selector (**Block layout**).

## Verify it worked

Edit a node whose paragraphs have the anchor field, tick **Anchor menu** on a few
paragraphs and give each a label, then save. On the rendered page, the anchor-menu
block should list those sections as jump links, scrolling to the matching
paragraph and highlighting the active section as you scroll.
