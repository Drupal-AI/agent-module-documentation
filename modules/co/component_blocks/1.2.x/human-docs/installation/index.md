# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0 || ^10.0 || ^11`).
- Core's **Block** (`block`) and **Layout Builder** (`layout_builder`) modules.
- The **UI Patterns** module (`ui_patterns`) — and specifically the **1.x**
  branch. The Composer constraint pins `drupal/ui_patterns ^1.0`; this module
  does not work with UI Patterns 2.x, which is a different architecture aligned
  with Single Directory Components.

You will also need a theme (or module) that actually defines UI Patterns
components for the blocks to be derived from.

## Install with Composer

From the project root:

```bash
composer require drupal/component_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in UI Patterns and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_blocks -y
```

This enables UI Patterns, Block, and Layout Builder as dependencies if they are
not already on.

## Verify it worked

Enable Layout Builder on a content type's display, edit its layout, and click
**Add block**. You should see one block per available UI Patterns component; add
one and its configuration form should offer to map the component's slots to the
entity's fields.
