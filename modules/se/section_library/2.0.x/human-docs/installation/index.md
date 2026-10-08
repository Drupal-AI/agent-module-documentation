# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Four core modules, all pulled in as dependencies: **Layout Builder**
  (`layout_builder`), **Image** (`image`), **Options** (`options`), and **Views**
  (`views`). Layout Builder is the whole point — Section Library extends its UI.

There are no third‑party Composer packages. One module is *suggested* (optional):

- **Layout Builder iFrame Modal** (`layout_builder_iframe_modal`) — swaps the
  narrow off‑canvas tray for a larger modal, giving the templates picker a roomier,
  more modern feel.

## Install with Composer

From the project root:

```bash
composer require drupal/section_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/section_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en section_library -y
```

Drupal enables the required core modules (Layout Builder, Image, Options, Views)
at the same time if they are not already on. After enabling, grant the relevant
permissions (see [Configuration](../configuration/index.md)) before editors can
save or import templates.

There are no submodules.
