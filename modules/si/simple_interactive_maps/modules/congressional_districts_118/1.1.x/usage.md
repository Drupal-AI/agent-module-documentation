A Simple Interactive Maps submodule that adds base maps for the 118th-Congress US congressional districts.

---

`congressional_districts_118` ships one `map_definition` plugin per US state (plus the District of Columbia and an "Undefined" fallback) whose `mapData()` returns the district region ids and SVG path data. The geometry is derived from the U.S. Census Bureau TIGER/Line shapefiles for the 118th Congress. It defines no routes, permissions, entities, config, or client behaviour of its own — it only supplies map data for the parent module to render. After enabling it, an administrator creates an `interactive_map` entity (at `/admin/structure/interactive-map`) whose base map is a district map, then colours districts, adds tooltips, groups them, and attaches click actions exactly as with any other base map.

---

- Show a state's 118th-Congress congressional districts as an interactive map.
- Colour districts by representing party or by any group.
- Link each district to a candidate, office, or content page.
- Give each district a rich-text hover tooltip.
- Pop up modal content when a district is clicked.
- Build a national navigation by loading state district maps via AJAX.
- Reuse one district base map across several configured interactive maps.
- Provide a Census-derived district visualisation without external map tiles.
