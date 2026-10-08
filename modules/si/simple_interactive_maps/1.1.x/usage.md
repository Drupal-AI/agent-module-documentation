<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Interactive Maps embeds a plugin-provided SVG map whose named regions respond to interaction — hover tooltip, click action, link, modal, or loading another map.

---

The maps themselves are not uploaded files; they are PHP `MapDefinition` plugins that return region path data. The module ships one such map (`us_states_territories` — the 50 states plus major-territory hotspots), and its two submodules add many more (per-state county maps and 118th-Congress district maps, both derived from US Census TIGER/Line shapefiles). To add a map that is not one of these, you write a small plugin class whose `mapData()` returns the region ids, labels, and SVG `path` data — there is no admin form for pasting or uploading SVG. Once a base map exists, an administrator creates an `interactive_map` config entity that selects that base map and, per region, overrides colours, sets a rich-text tooltip, groups regions, and attaches a click action. The built map is embedded as a block, through a text-format filter (a `<simple-map>` embed inserted with the CKEditor 5 button, or a legacy `[interactive_map map=ID]` shortcode), or loaded over AJAX from another map. Regions and groups can be edited in a table UI and round-tripped as JSON via the per-map Tools tab (region/group import and export).

Clicking a region runs its action plugin in the browser: `none` (inert), `navigate_action` (go to a URL, optionally a new tab), `modal_content` (open a Drupal dialog with filter-processed HTML), or `ajax_load_map` (replace the current map with another). Tooltips and modal bodies are run through Drupal text formats, so their output is only as safe as the format an administrator picks.

Configuring maps requires the `administer interactive_map` permission; the module-wide colour defaults live behind `administer site configuration`. As with any interactive diagram, the interaction is only accessible if you also provide keyboard equivalents, accessible region names, and a non-map alternative (a list of the same links) for anyone who cannot use the map — that part is a content responsibility, not a switch in the module.

---

- Embed a clickable map of the US states in a block.
- Turn a regional map into a visual navigation menu.
- Pop up a modal with content when a region is clicked.
- Load a drill-down map (state → counties) with AJAX from a parent map.
- Show US congressional districts (118th Congress) as an interactive map.
- Show a single state's counties as an interactive map.
- Embed a map inside body text with the CKEditor 5 "Insert map" button.
- Embed a map with the legacy `[interactive_map map=ID]` shortcode.
- Give each region a rich-text hover tooltip.
- Colour regions by group (e.g. party, region, status) with shared colours.
- Override fill / stroke / hover / text colours per region or per group.
- Hide specific regions from a base map.
- Link each region to a different URL.
- Define a custom map by writing a `MapDefinition` plugin.
- Define a custom click behaviour by writing a `MapAction` plugin.
- Set site-wide default fill/stroke/hover/text colours for new maps.
- Preview a map before placing it, from the admin Preview tab.
- Bulk-edit region labels, tooltips, colours, and actions in a table.
- Export a map's region or group configuration to JSON and re-import it.
- Serve a map as a standalone SVG image via its thumbnail route.
- Reuse one base map for several differently-configured interactive maps.
- Add a state-counties or district map without touching the parent module.
- Group regions and override their action or tooltip in one place.
- Build an org chart, floor plan, or seating diagram as a named-region SVG map.
