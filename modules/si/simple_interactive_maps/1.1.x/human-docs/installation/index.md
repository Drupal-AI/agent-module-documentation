# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Field Group** module (`field_group`) — a contrib module you install
  alongside this one.
- Core's **File** module (`file`) and **Filter** module (`filter`), both of which
  Drupal ships; they are enabled automatically as dependencies.

There are no additional PHP libraries or third‑party Composer packages beyond the
Field Group module, which Composer will pull in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_interactive_maps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Field Group module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_interactive_maps -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_interactive_maps -y
```

Drupal will enable Field Group, File, and Filter as needed.

## Verify it worked

After enabling, an administrator (with the **administer interactive_map** permission)
can work with the bundled US maps or upload a custom SVG map. If you can reach the
map management area and see the included maps, the module is installed correctly.
Remember that uploading SVG maps should stay an administrator task — an SVG can carry
scripts, so treat map uploads as you would HTML uploads.
