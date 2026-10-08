# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)**
  module (`layout_builder_restrictions`) — this module is a plugin for it. (Layout
  Builder Restrictions in turn builds on core's **Layout Builder**.)

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_restrictions_by_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Layout Builder
Restrictions (and core's Layout Builder if needed) and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_restrictions_by_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drupal will offer to enable Layout
Builder Restrictions and Layout Builder automatically):

```bash
drush en layout_builder_restrictions_by_role -y
```

## Turn on the "Per Role" plugin

Enabling the module is **not** enough — you must also switch on its restriction
plugin. Go to **Structure → Layout Builder Restrictions** and enable the **Per
Role** restriction. Until you do, no per-role configuration or enforcement appears.

## What to do next

Once the *Per Role* plugin is enabled, set your global defaults and any
per-view-mode overrides — see [How to use it](../index.md#how-to-use-it) in the
overview. Remember these rules only refine what editors who already hold Layout
Builder editing permissions can do.
