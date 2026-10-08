# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: >=11.1.0`). There is
  **no Drupal 10 support** — check your core version first.
- The **UI Icons** module and its submodules (`ui_icons`, `ui_icons_menu`,
  `ui_icons_field`), which provide the Icon‑API integration this module plugs into.
- **Outbound HTTPS access to the Iconify API** so icons can be fetched (see the
  egress note in [Configuration](../configuration/index.md)).
- No PHP library requirements — the released package includes the built CSS, so a
  front‑end (yarn) build is not needed to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/iconify_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iconify_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

There are two ways to set it up.

### Recommended: the Icons Toolkit recipe

The maintainers recommend applying the **Icons Toolkit** recipe, which
automatically installs all required modules and applies a fully preconfigured
setup — no manual configuration needed. If you use this route, follow the recipe's
own instructions and you can skip the manual steps below.

### Alternative: manual installation

1. Install and enable the **UI Icons** modules and their required submodules:
   `ui_icons`, `ui_icons_menu`, and `ui_icons_field`.
2. Enable Iconify Icons (version 2.0.x):

   ```bash
   drush en iconify_icons -y
   ```

3. When adding a new icon field or inserting an icon into a menu, select the
   desired icon set from the available Iconify collections.

> **Note:** Iconify Icons **1.0.x is deprecated** and receives security releases
> only — install the **2.0.x** line for new sites.

## Verify it worked

Open the settings form at **`/admin/config/iconify_icons/settings`**, choose one
or more icon sets, and save (see [Configuration](../configuration/index.md)). Then
add an icon field or insert an icon into a menu and confirm the Iconify collections
appear in the picker and render as inline SVG.
