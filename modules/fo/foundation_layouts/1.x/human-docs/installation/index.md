# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) — this is the only
  dependency, and Drupal enables it automatically. (It is the bundled core module
  that provides the layout plugin system these layouts plug into.)
- A theme that uses the **ZURB Foundation** grid system, so the emitted grid classes
  have styling to attach to. This isn't enforced as a code dependency, but the
  layouts only behave as intended on a Foundation front end.
- A layout tool to actually place content — **Layout Builder** (core), **Display
  Suite**, or **Panels**. Any of these consumes the layouts.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/foundation_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/foundation_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en foundation_layouts -y
```

Core's Layout Discovery is enabled at the same time if it wasn't already.

## Verify it worked

Open a place where you build layouts — for example enable **Layout Builder** on a
content type and add a section. The ZURB Foundation grid layouts should now appear in
the list of available layouts next to Drupal's built‑in ones. Choose one and confirm
the rendered page uses Foundation's grid classes.
