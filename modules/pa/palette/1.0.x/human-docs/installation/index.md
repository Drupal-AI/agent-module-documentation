# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Color Field** (`color_field`) — Palette adds its widget on top of this
  module's field type.
- **Entity Browser** (`entity_browser`) — powers the visual swatch modal and the
  inline "add a color" widget.

Composer installs both contrib dependencies for you when you require the module
with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/palette -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Color Field and Entity Browser.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/palette -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en palette -y
```

Drupal enables Color Field and Entity Browser automatically as dependencies.

## Verify it worked

Log in as an administrator and go to **Structure → Palette colors**
(`/admin/structure/palette-colors`) — you should see the (empty) collection with
an **Add palette color** button. Add your first color, then follow "How to use
it" in the [overview](../index.md) to switch a Color Field to the Palette widget.
