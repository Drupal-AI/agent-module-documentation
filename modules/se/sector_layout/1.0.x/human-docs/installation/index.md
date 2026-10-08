# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — the only dependency, and
  Drupal enables it automatically when you turn on Sector Layout.

There are no third-party PHP or library requirements, and there are no submodules.
It is intended for **Sector** distribution sites.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_layout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_layout -y
```

Enabling it will also enable Layout Builder if it is not already on.

## Verify it worked

Open a layout in **Layout Builder** (for example on a content type's *Manage
display*, or on an individual node if per-entity layouts are enabled), add a
section, and confirm the Sector layouts appear in the layout chooser. There is no
settings page to visit.
