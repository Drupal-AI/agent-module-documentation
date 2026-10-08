# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** enabled (the module contributes a layout plugin to
  it).

There are no third-party Composer or JavaScript libraries — the flip effect is
**pure CSS**.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_flipcard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_flipcard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_flipcard -y
```

## Verify it worked

Edit a Layout Builder layout, add a section, and confirm the **flip-card** layout
appears among the layout choices. Place a block in the front and back regions,
save, and view the page — the card should flip to show the back face on hover or
click.
