<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embedding a map: block, filter, CKEditor, AJAX, tools

A built map is placed with `#theme => 'interactive_map'` (preprocess attaches libraries + settings).
The wrappers below expose that render.

## Block

`src/Plugin/Block/InteractiveMapBlock.php`, id `simple_interactive_maps_interactive_map`, category
"Maps". Block config: `map` (select of `interactive_map` entities, required), `show_description`
(bool; `title`/`show_title` also in schema `block.settings.simple_interactive_maps_interactive_map`).
`build()` renders `#theme interactive_map_block` wrapping `#theme interactive_map`; description is a
`#type processed_text` of the map's `description {value, format}`. Cache: `url` context + map cache
tags, `PERMANENT` max-age.

## Text-format filter

`src/Plugin/Filter/MapFilter.php`, id `simple_interactive_maps_map_filter`,
`TYPE_TRANSFORM_REVERSIBLE`. `process()` handles two embed syntaxes and renders the referenced map:

- **CKEditor embed:** `<simple-map data-map-id="ID" data-show-description="true|false">` — parsed
  with `Html::load()` + `DOMXPath` over `//simple-map[@data-map-id]`, each replaced by the rendered
  map (`replaceNode()` via a document fragment). `data-show-description` toggles the description.
- **Legacy shortcode:** `[interactive_map map=ID]` (`preg_match`, id charset `[a-zA-Z0-9_]`) →
  rendered map. `InteractiveMap::getEmbedCode()` returns this string.

In both cases the map id is used to `load()` an `interactive_map` config entity; unknown ids are
left untouched. Each embed adds the map as a cacheable dependency. `tips()` returns a short label.

## CKEditor 5 integration

`simple_interactive_maps.ckeditor5.yml` defines the `simpleInteractiveMaps` toolbar item; JS build
in `js/build/simpleInteractiveMaps.js` (source under `js/ckeditor5_plugins/`). Plugin class
`src/Plugin/CKEditor5Plugin/SimpleInteractiveMaps.php` injects `dialogURL` =
`simple_interactive_maps.editor_dialog`. `src/Form/EditorDialogForm.php` (route
`/admin/simple-interactive-maps/editor-dialog`, `administer interactive_map`) is the map-picker
modal; on submit it returns an `EditorDialogSave` AJAX command inserting the `<simple-map>` element.
Libraries `ckeditor5_embed_map` / `ckeditor5_embed_map_admin` (`*.libraries.yml`).

## AJAX map loader (`ajax_load_map` target)

`src/Controller/AjaxMapLoaderController.php`, route `simple_interactive_maps.ajax_map_loader`
`/simple-interactive-maps/ajax`, permission `access content`. Reads POST `map_to_load` +
`target_element`, `load()`s that `interactive_map` config entity (404 if absent), renders
`#theme interactive_map` with `renderInIsolation()`, and returns an `AjaxResponse` with a
`ReplaceCommand('#<target_element>', ...)`, re-attaching the isolated render's `#attached` libraries
so the new map is interactive. Renders admin-defined config entities only.

## Read/render endpoints (both `access content`)

- `simple_interactive_maps.map_thumbnail` `/admin/structure/interactive-map/{map}/thumbnail`
  (`MapThumbnailController`) — renders the map SVG as `image/svg+xml` (`CacheableResponse`, uses
  `MapBuilder` context `thumbnail`).
- `simple_interactive_maps.map_data` `/map-data/ajax/fetch` (`MapDataController`) — returns a
  `CacheableJsonResponse`; calls `MapDataLoader::loadMapData()` and returns a 500 JSON error on
  failure.

## Tools: import / export (per map, `administer interactive_map`)

Tab `simple_interactive_maps.simple_interactive_maps_tools` (`MapToolsController`, template
`interactive-map-tools.html.twig`; `template_preprocess_interactive_map_tools()` builds the four
tool URLs).

- **Export:** `RegionExportController` / `GroupExportController` extend
  `DataExportControllerBase::exportCsvFile()` — write a `temporary://` CSV via `fputcsv` and return
  a private `BinaryFileResponse` attachment. Region rows carry id, label, hidden, group, colours,
  tooltip value/format, action plugin + `Yaml::dump`ed action configuration.
- **Import:** `Form\RegionDataImportForm` / `Form\GroupDataImportForm` extend
  `DataImportFormBase`, which validates the upload with `file_save_upload(..., ['FileExtension' =>
  ['extensions' => 'csv CSV']], ...)` and writes the parsed rows back onto the entity's
  regions/groups.

## Other pieces

- `ClippableContent` (service `simple_interactive_maps.clippable_content`) — render helper that wraps
  a string with a copy-to-clipboard link (library `clippable_content`), used to surface embed codes.
- Services recap: `map_builder`, `map_data_loader`, `clippable_content`,
  `plugin.manager.map_definition`, `plugin.manager.map_action`,
  `logger.channel.simple_interactive_maps`, `event_subscriber`, and the region/group/table
  controllers (`simple_interactive_maps.controller.*`).
- `simple_interactive_maps.post_update.php` holds post-update hooks; `SimpleInteractiveMapsLoggerTrait`
  provides the module logger channel.
