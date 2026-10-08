# Installation

## Requirements

Field View Mode needs:

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Field UI** module — enabled automatically as a dependency. It's what
  the settings form uses to create and place the selection field.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fvm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fvm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fvm -y
```

Enabling the module adds its settings form but does not change any bundle yet —
you turn Field View Mode on per bundle from the form.

## After enabling

1. Confirm the content types (or other bundles) you want to control have **more
   than one view mode** enabled — Field View Mode only offers bundles that do.
2. Go to **Structure → Display modes → View modes → Field View Mode**
   (`/admin/structure/display-modes/view/fvm`) and enable the bundles you want.
   See [Configuration](../configuration/index.md).

You don't create any field by hand — the settings form does it for you when you
enable a bundle.
