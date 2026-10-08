<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# US State County Maps (us_state_county_maps) — agent index

Submodule of **simple_interactive_maps**. Pure **map data provider**: adds `map_definition`
plugins of each US state and territory showing county borders. No routes, permissions, entities,
config, services, or JS of its own. Core `^10.3 || ^11`, PHP `>=8.3`.
Depends on `simple_interactive_maps`.

## What it adds

- **56 `map_definition` plugins** in `src/Plugin/MapDefinition/` — one `*CountiesMap` class per
  state/territory (50 states + District of Columbia + American Samoa, Guam, Commonwealth of the
  Northern Mariana Islands, Puerto Rico, US Virgin Islands). Each has
  `#[MapDefinition(id: '<state>_counties', label: '<State> Counties Map', map_category: 'US Census
  Bureau County Maps')]` and a `mapData()` returning county region ids + SVG `path` data (Census
  TIGER/Line).

## Usage

Enable the module, then create an `interactive_map` config entity whose `base_map` is one of these
plugin ids. Rendering, colours, tooltips, groups, and click actions are all handled by the parent
module — see `../../../../simple_interactive_maps/1.1.x/agent/start.md` and its
`plugins/maps-and-regions.md` for the render pipeline and `mapData()` shape.
