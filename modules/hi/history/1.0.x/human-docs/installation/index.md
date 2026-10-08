# Installation

## Requirements

History is lightweight and has no third-party libraries. It needs:

- **Drupal newer than 11.3** (`core_version_requirement: >11.3`). This module is the
  former core `history` module, published as contrib for versions of Drupal where
  it no longer ships in core.
- Core's **Node** module (`node`), enabled automatically as a dependency.
- Core's **Comment** module is optional — the "new comments" field, the comment
  "new" indicator, and the `comment-count-new` token light up only when Comment is
  enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/history -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en history -y
```

That's all. There are no submodules and no configuration. Read-tracking begins
immediately for logged-in users, and the "New"/"Updated" markers reappear on
content listings. To use it in your own listings, add the History field/filter to a
view as described in the [overview](../index.md#in-views).

> **Restoring it on an upgraded site:** if you're on a Drupal newer than 11.3 that
> used to rely on the core `history` module, simply enabling this contrib module
> restores that behavior — existing views and markers continue to work without
> changes.
