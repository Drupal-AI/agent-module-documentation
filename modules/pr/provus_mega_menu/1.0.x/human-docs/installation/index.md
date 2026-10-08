<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Menu Item Extras** (`menu_item_extras`) — a hard dependency, enabled automatically.
- The **Provus base theme** at runtime. This module is designed to run inside the
  Provus theme: its CSS/JS library depends on `provus_base_theme/global-styling`, and
  the callout/icon fields it renders are supplied by the Provus distribution/recipe.
  Outside a Provus theme those styles and fields will be missing.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/provus_mega_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Menu Item Extras) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/provus_mega_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en provus_mega_menu -y
```

This also enables Menu Item Extras if it was not already on. There are no submodules
and no configuration form.

## After enabling

Because this module is presentation-only, two things need to be in place for it to look
right:

1. **The Provus base theme must be active** (or a subtheme of it), so the required
   global styling library is present.
2. **The Provus callout/icon fields must exist** on the main menu's link content —
   `field_provus_menu_callout_image`, `field_provus_menu_callout_link`, and
   `field_provus_menu_icon`. These are provided by the Provus distribution/recipe. If
   you are assembling a Provus site from its recipe, they will already be there.

Once both are in place, edit your main-menu links and fill in the callout/icon fields —
see [How to use it](../index.md#how-to-use-it) on the overview page.
