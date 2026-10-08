# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core modules only — **Node** (`node`), **User** (`user`), **System**
  (`system`), and **Layout Builder** (`layout_builder`). The button is injected
  only on displays built with Layout Builder, so make sure your node type's
  **full** view mode uses it.

There are no contributed-module dependencies, no third‑party PHP libraries, and no
external JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/ez_likes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ez_likes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ez_likes -y && drush cr
```

Enabling the module automatically creates its `ez_likes_events` database table.

## Verify it worked

Visit a full node page whose display uses **Layout Builder**. You should see the
EZ Likes action bar with the Share button at the bottom of the content. If it
isn't there, confirm that node type's full view mode is built with Layout Builder,
and that the page isn't excluded by a path rule. Next, see
[Configuration](../configuration/index.md) to tailor where the button appears and
to open the analytics report.
