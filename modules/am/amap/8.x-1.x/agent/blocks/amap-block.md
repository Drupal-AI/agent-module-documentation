<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# aMap block (`amap_block`)

Everything the module does lives in `src/Plugin/Block/AmapBlock.php` (extends `BlockBase`),
`amap.module`, `templates/amap.html.twig`, and `js/amap.js`.

## Install & place

1. `drush en amap` (pulls core `node` + `block`, already in most sites).
2. Block layout (`/admin/structure/block`) → *Place block* → **aMap Block** (category *aMap*).
   Placing/configuring the block requires the core **`administer blocks`** permission.
3. Configure the six fields (below), then arrange the region as usual.

The block renders the bundled `svg/usa_oa.svg` inline (via Twig `source()`), so the map graphic is
served from the module — no external map tile/service or API key is involved.

## Settings (per block instance)

`blockForm()` collects these; `blockSubmit()` stores them in `$this->configuration`, and
`build()` attaches the whole array to `drupalSettings.amap`. There is **no `config/schema`**, so
these are plain untyped block config strings.

| Key | Form title | Meaning |
| --- | --- | --- |
| `svg_url` | URL for ajax SVG class/style | Endpoint the JS fetches (GET) for the JSON rows. Maxlength 2000. |
| `svg_url_path` | URL Path Component Start for Parameters | Integer 0–9 (maxlength 1). `0` (default) appends nothing; `>0` appends the current page's path segments from that index onward to `svg_url`. |
| `svg_eid_mn` | SVG Element ID field / machine name | JSON key whose value is used as the **SVG element id** to target (`#<value>`). |
| `svg_eid_class_mn` | Class containing field / machine name | JSON key whose value is added as a **CSS class** to the element (and its `_Label`). |
| `svg_eid_style_mn` | Style containing field / machine name | JSON key whose value is set as the element's **`fill`** style (element + `_Label`). |
| `svg_eid_url_mn` | Field / machine name for SVG URL (click) | JSON key whose value becomes the **click target**; element, `_Label`, `_Text` navigate to it. |

`defaultConfiguration()` returns only `parent::defaultConfiguration()` (no defaults for the six
keys), so an unset block form field reads as an undefined index until first saved.

## AJAX / JSON contract (`js/amap.js`, `Drupal.behaviors.amap`)

- The behavior reads `drupalSettings.amap`. If `svg_url_path > 0`, it splits
  `location.pathname` on `/`, keeps segments at index `>= svg_url_path`, appends them plus
  `window.location.search` to `svg_url`. Then `$.ajax({url: svg_url, method: 'GET'})`.
- On success it expects a **JSON array**; for each `obj` (row):
  - if `svg_eid_class_mn !== ''`: `$('#'+obj[svg_eid_mn]).addClass(obj[svg_eid_class_mn])` (and the
    `#<id>_Label`).
  - if `svg_eid_style_mn !== ''`: `.css({fill: obj[svg_eid_style_mn]})` on element and `_Label`.
  - if `svg_eid_url_mn !== ''`: sets `cursor:pointer` and a click handler that does
    `window.location = obj[svg_eid_url_mn]` on the element, its `_Label`, and its `_Text`.
- So the SVG must contain elements whose `id` equals each row's `svg_eid_mn` value (the bundled
  `usa_oa.svg` uses state ids), optionally with matching `<id>_Label` / `<id>_Text` siblings.

The fetch is **client-side** (the visitor's browser calls `svg_url`), not a server-side request.
Point `svg_url` at a JSON source you control — e.g. a Views REST export returning
`[{ "state": "CA", "cls": "amap-active", "fill": "#3366ff", "link": "/node/12" }, ...]` mapped so
`svg_eid_mn=state`, `svg_eid_class_mn=cls`, `svg_eid_style_mn=fill`, `svg_eid_url_mn=link`.

## Theme & assets

- `hook_theme()` registers `amap` with variables `items` (`[]`) and `attributes`
  (`class => ['amap-class']`). `amap_preprocess()` sets `amap_module_path` for every hook.
- `templates/amap.html.twig`: `{{ attach_library('amap/core') }}`, a `<div{{ attributes }}>`, and
  `{{ source(amap_module_path ~ '/svg/usa_oa.svg') }}`. Override by copying the template into your
  theme (e.g. to embed a different bundled SVG).
- `css/amap.css` ships one example rule: `.amap-unpublished { fill: #f5e742; }` — a class you can
  return via `svg_eid_class_mn` to tint regions.

## Notes

- No update path / schema: block config is untyped; changing the six keys just rewrites block
  config on save.
- The map graphic is fixed to `usa_oa.svg` in the template; other regions/countries require a
  template override with a different SVG whose element ids match your data.
