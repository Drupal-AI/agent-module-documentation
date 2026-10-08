<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Interactive Maps (simple_interactive_maps) — agent index

Embeds **SVG maps with interactive, named regions** (hover tooltip, click action, link, modal,
AJAX drill-down). Maps are **PHP plugins**, not uploaded files. Version **1.1.0**.
Core `^10.3 || ^11`. PHP `>=8.3`. Depends on `field_group`, `file`, `filter`.

## What it provides

- **Config entity** `interactive_map` (`src/Entity/InteractiveMap.php`) — selects a base map and
  stores per-region + per-group overrides (colours, tooltip, action, group). Admin at
  `/admin/structure/interactive-map`. Permission: `administer interactive_map`.
- **Two plugin types** (both attribute-discovered under `src/Plugin/`):
  - `map_definition` — a named map's region path data. Ships `us_states_territories`
    (`Plugin/MapDefinition/UnitedStates.php`). Submodules add county and district maps.
  - `map_action` — client-side click behaviour. Ships `none`, `navigate_action`,
    `modal_content`, `ajax_load_map` (`src/Plugin/MapAction/`).
- **Block** `simple_interactive_maps_interactive_map`, **filter** `simple_interactive_maps_map_filter`
  (`<simple-map>` embed + `[interactive_map map=ID]` shortcode), and a **CKEditor 5** "Insert map"
  button.
- **Settings** config object `simple_interactive_maps.settings` (default colours) at
  `/admin/config/system/interactive-map-settings` (`administer site configuration`).
- Services: `simple_interactive_maps.map_builder` (SVG render array + JS settings, cached),
  `simple_interactive_maps.map_data_loader` (merges config over plugin data),
  `plugin.manager.map_definition`, `plugin.manager.map_action`,
  `simple_interactive_maps.clippable_content`.

## Solution docs

- **Install, the `interactive_map` config entity, settings, routes, permissions** →
  [config/settings.md](config/settings.md)
- **Base maps: the `map_definition` plugin type, `mapData()` shape, and the SVG render pipeline
  (`MapBuilder` / `MapDataLoader` / `SvgHelper`)** → [plugins/maps-and-regions.md](plugins/maps-and-regions.md)
- **Click behaviours: the `map_action` plugin type and the four shipped actions + their JS** →
  [plugins/actions.md](plugins/actions.md)
- **Embedding: block, text-format filter, CKEditor 5, AJAX loader, thumbnail, tools
  import/export** → [embedding/embed.md](embedding/embed.md)

## Submodules (own doc trees under `../modules/`)

- `congressional_districts_118` — 118th-Congress district maps (map_definition plugins).
- `us_state_county_maps` — per-state/territory county maps (map_definition plugins).
