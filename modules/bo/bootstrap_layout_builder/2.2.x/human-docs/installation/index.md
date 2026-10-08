# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — provides the layout
  system BLB extends. Drupal enables it as a dependency.
- The **Bootstrap Styles** module (`drupal/bootstrap_styles`, `^1.2.0`) — the
  styling engine behind the Style tab. Composer pulls it in, and it in turn pulls
  in Media Library Form Element.

BLB provides the Bootstrap grid classes it references, but your **front‑end
theme** should load Bootstrap's CSS for the grid to look right on the rendered
page. (In the Layout Builder admin canvas the classes are applied regardless.)

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_layout_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Bootstrap Styles
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_layout_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_layout_builder -y
```

Enabling BLB also turns on Layout Builder and Bootstrap Styles (and Media Library
Form Element) if they aren't already active. BLB ships **no submodules**.

## Verify it worked

Enable Layout Builder for a content type's view mode, click **Manage layout →
Add section**, and confirm you see **Bootstrap** layout options (Bootstrap 1
Cols, 2 Cols, and so on). Then head to
[Configuration](../configuration/index.md) for the settings and the per‑section
UI.
