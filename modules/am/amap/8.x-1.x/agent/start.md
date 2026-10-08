<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# aMap (amap) — agent index

A single **block plugin** that embeds a bundled inline **SVG map of the USA** and, via a small
client-side jQuery behavior, fetches JSON from an admin-configured URL to recolor, restyle, and
link the map's regions. Package `aMap`. Depends only on core **`node`** and **`block`**. Core
requirement `^10.1 || ^11`. License GPL-2.0-or-later. Version 8.x-1.1.

- **The block, all six settings, the AJAX/JSON contract, and how to operate it** →
  [blocks/amap-block.md](blocks/amap-block.md)

## What it actually is

- One plugin: `AmapBlock` (`@Block` id **`amap_block`**, label *"aMap Block"*, category *"aMap"*),
  in `src/Plugin/Block/AmapBlock.php`, extending core `BlockBase`. **No** field type/widget/
  formatter, **no** permissions file, **no** routing/services, **no** `.install`, **no**
  `config/schema` or `config/install`. All configuration is standard per-block-instance config.
- `amap.module`: `hook_theme()` registers the **`amap`** theme hook; `amap_preprocess()` exposes
  `amap_module_path` to templates; `hook_help()` for `help.page.amap`.
- `templates/amap.html.twig` renders `{{ source(amap_module_path ~ '/svg/usa_oa.svg') }}` inside a
  `<div{{ attributes }}>` and attaches the `amap/core` library.
- Library `amap/core` (`amap.libraries.yml`): `js/amap.js` + `css/amap.css`, depending on
  `core/jquery`, `core/drupal.ajax`, `core/drupal`, `core/drupalSettings`.
- Bundled assets: `svg/usa.svg`, `svg/usa_oa.svg` (the base graphics); `css/amap.css` (one
  example class, `.amap-unpublished`).

## Mechanism (from source)

- `AmapBlock::build()` returns `['#theme' => 'amap']` and attaches the whole block config to
  `drupalSettings.amap`. `blockForm()`/`blockSubmit()` persist six string settings (below).
- `js/amap.js` (`Drupal.behaviors.amap`) reads `drupalSettings.amap`, optionally appends path
  segments (from `svg_url_path`) and the current query string to `svg_url`, does a jQuery
  `$.ajax` **GET**, then loops the JSON array applying class / `fill` / click-navigation to
  `#<row[svg_eid_mn]>`, its `_Label`, and `_Text` siblings.

See [blocks/amap-block.md](blocks/amap-block.md) for the settings table and JSON shape.
