<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# 118th Congressional Districts (congressional_districts_118) — agent index

Submodule of **simple_interactive_maps**. Pure **map data provider**: adds `map_definition`
plugins for the 118th-Congress US congressional-district maps. No routes, permissions, entities,
config, services, or JS of its own. Core `^10.3 || ^11`, PHP `>=8.3`.
Depends on `simple_interactive_maps`.

## What it adds

- **52 `map_definition` plugins** in `src/Plugin/MapDefinition/` — one `*CongressionalDistrictsMap`
  class per state, plus `DistrictOfColumbiaCongressionalDistrictsMap` and
  `UndefinedCongressionalDistrictsMap`. Each has
  `#[MapDefinition(id: '<state>_congressional_districts', label: '<State> Congressional Districts
  Map', uses_default_tooltip: TRUE, map_category: 'US Census Bureau 118th Congressional District
  Maps')]` and a `mapData()` returning district region ids + SVG `path` data (Census TIGER/Line,
  118th Congress).

## Usage

Enable the module, then create an `interactive_map` config entity whose `base_map` is one of these
plugin ids. Rendering, colours, tooltips, groups, and click actions are all handled by the parent
module — see `../../../../simple_interactive_maps/1.1.x/agent/start.md` and its
`plugins/maps-and-regions.md` for the render pipeline and `mapData()` shape.
