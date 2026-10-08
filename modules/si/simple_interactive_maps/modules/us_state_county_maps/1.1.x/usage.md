A Simple Interactive Maps submodule that adds base maps of each US state and territory showing county borders.

---

`us_state_county_maps` ships one `map_definition` plugin per US state and territory whose `mapData()` returns the county region ids and SVG path data. The geometry is derived from the U.S. Census Bureau TIGER/Line shapefiles. It defines no routes, permissions, entities, config, or client behaviour of its own — it only supplies map data for the parent module to render. Coverage includes the 50 states, the District of Columbia, and the territories (American Samoa, Guam, Commonwealth of the Northern Mariana Islands, Puerto Rico, US Virgin Islands). After enabling it, an administrator creates an `interactive_map` entity whose base map is a county map, then colours counties, adds tooltips, groups them, and attaches click actions like any other base map.

---

- Show a state's counties as an interactive map.
- Colour counties by any grouping (region, status, metric band).
- Link each county to a content page or external URL.
- Give each county a rich-text hover tooltip.
- Pop up modal content when a county is clicked.
- Drill from a state map down to its counties via AJAX.
- Map counties for a US territory, not just the 50 states.
- Reuse one county base map across several configured interactive maps.
