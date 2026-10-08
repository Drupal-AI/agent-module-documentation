<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring mega menus

We Mega Menu has **no settings form and no `configure` route** (`configure: null` in info.yml).
There is no config entity and no config schema. Instead each menu's mega-menu layout is a JSON
document stored in a **custom database table `we_megamenu`** (see `we_megamenu.install`):

| column | type | note |
|---|---|---|
| `menu_name` | varchar(150) | core menu machine name (e.g. `main`), part of primary key |
| `theme` | varchar(100) | theme machine name (e.g. `olivero`), part of primary key |
| `data_config` | longtext | the layout + behavior as a JSON string |

So config is **per `(menu_name, theme)` pair** — a menu can have a different mega-menu layout
under each theme. Nothing is exported with `drush cex`; it lives only in the database.

## Builder UI

1. Build menu links normally at **Structure > Menus** (`/admin/structure/menu`).
2. Go to **Structure > Mega Menu** (`/admin/structure/we-mega-menu`, route `we_megamenu.admin`).
   This lists every menu with a **Config** operation.
3. Config opens `/admin/structure/we-mega-menu/{menu_name}/config`
   (route `we_megamenu.admin.configure`) — the drag-and-drop builder. Here you split dropdowns
   into rows/columns, set column widths, drop Drupal blocks into columns, assign icons/captions,
   and set the menu's animation/behavior.
4. Saving posts via AJAX to `we_megamenu.admin.save` (`/admin/structure/we-mega-menu/save`),
   which calls `WeMegaMenuBuilder::saveConfig()`. Reset posts to `we_megamenu.admin.reset`.

Then **place the front-end block** — see [../plugins/megamenu-block.md](../plugins/megamenu-block.md).

Everything above is gated by the `administer we_megamenu` permission.

## `block_config` — per-menu render behavior

`data_config` contains a `block_config` object (defaults set by `WeMegaMenuBuilder::initMegamenu()`).
These map to `data-*` attributes on the rendered `<nav>` and drive the front-end JS:

| key | default | meaning |
|---|---|---|
| `style` | `Default` | menu skin/style name |
| `animation` | `None` | dropdown open animation (e.g. `fadeInUp`) |
| `delay` | `''` | animation delay (ms) |
| `duration` | `''` | animation duration (ms) |
| `auto-arrow` | `''` | auto-append dropdown arrow |
| `always-show-submenu` | `''` | keep submenu visible |
| `action` | `hover` | open trigger: `hover` or `clicked` |
| `auto-mobile-collapse` | `0` | collapse to hamburger on mobile |

Per-item settings live under `menu_config.<derivativeId>` (rows/columns, `col_config.width`
`span1`..`span12`, `col_config.block` for an embedded block, `col_config.block_title`,
`col_config.hidewhencollapse`, `item_config` icon/caption/class/group/target). The full JSON shape
is documented in [../api/builder.md](../api/builder.md).

## Seed or read config programmatically (deploy-friendly)

Because there is no exportable config, seed a menu's mega-menu row in an update hook / deploy
script instead of clicking through the UI:

```php
// Create a fresh layout for a menu under the current default theme.
$theme = \Drupal::config('system.theme')->get('default');
\Drupal\we_megamenu\WeMegaMenuBuilder::initMegamenu('main', $theme);

// Tweak behavior and save.
$cfg = \Drupal\we_megamenu\WeMegaMenuBuilder::loadConfig('main', $theme);
$cfg->block_config->action = 'clicked';
$cfg->block_config->animation = 'fadeInUp';
\Drupal\we_megamenu\WeMegaMenuBuilder::saveConfig('main', $theme, json_encode($cfg));
```

`initMegamenu()` reads the menu's link tree and writes a matching row; `loadConfig()` returns the
decoded object (or `FALSE`); `saveConfig()` upserts (DB `merge`) the JSON string.

## Backend builder skin

The builder's editing skin is stored in **state**, not config:
`\Drupal::state()->get('we_megamenu_backend_style')` (set via the `we_megamenu.admin.style` AJAX
route). It only affects the admin builder page, not the front end.
