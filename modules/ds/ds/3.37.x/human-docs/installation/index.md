# Installation

## Requirements

Display Suite needs **Drupal 10.2+ or 11**. Its only hard dependency is a core
module, which Drupal enables for you:

- **Layout Discovery** (`layout_discovery`) — core's Layout API. Display Suite's
  layouts (one-column, two-column, stacked, and so on) are ordinary layout
  plugins discovered through this module.

Optional but useful:

- **Field Group** (`drupal/field_group`) — lets you group fields into containers
  (tabs, accordions, fieldsets) *inside* a Display Suite layout. Install it
  separately (`composer require drupal/field_group`) if you want that.

## Install with Composer

From the project root:

```bash
composer require drupal/ds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ds -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ds -y
```

This also enables core's `layout_discovery` module. Once enabled, the Display
Suite control panel appears under **Structure → Display Suite**
(`/admin/structure/ds`).

## Optional submodules

Display Suite ships several optional submodules, each enabled separately with
`drush en <name> -y`:

- **Display Suite Extras** (`ds_extras`) — less-common display features such as
  block regions (regions exposed as placeable blocks), extra fields, per-field
  view permissions, and a hidden region.
- **Display Suite Switch View Mode** (`ds_switch_view_mode`) — adds a control on
  the node edit form so an editor can choose which view mode a specific node
  renders with.
- **Display Suite Devel** (`ds_devel`) — development and debugging helpers for DS
  displays; depends on the Devel module. Enable it only in development.

You do not need any of these for the core workflow — enable them only if you need
the feature they provide.

## Verify it worked

Log in as an administrator and go to **Structure → Display Suite**
(`/admin/structure/ds`). You should see the **Displays** overview listing every
entity type and bundle on your site, each with a **Manage display** button:

![The Display Suite Displays overview after installation](../images/structure.png)

If the page loads and the **Displays**, **Classes**, and **Fields** tabs are
present, the module is installed correctly. Next, head to
[Configuration](../configuration/index.md) to apply your first layout.
