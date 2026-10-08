# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and it must be on for the link to have anywhere to point.
- **Optional:** the
  [Layout Builder Asymmetric Translation](https://www.drupal.org/project/layout_builder_at)
  module (`layout_builder_at`). When layouts are translatable, it lets the Layout
  link target the correct translation.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_operation_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_operation_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_operation_link -y
```

There are no submodules and no configuration. The Layout link appears
automatically on the operations dropbutton for any bundle that has Layout Builder
overrides turned on.

## The actual setup: enable Layout Builder overrides

The link only shows where per‑entity overrides are enabled. To turn them on for a
bundle in the UI, go to **Structure → Content types → (type) → Manage display**,
check **Use Layout Builder** and **Allow each content item to have its layout
customized**, and **Save**.

To do the same from Drush (here for Article nodes):

```bash
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $d->enableLayoutBuilder()->setOverridable()->save();
'
drush cr
```

After that, log in as a user who can edit layouts and visit `/admin/content` — the
**Layout** link will be in each item's operations dropbutton.
