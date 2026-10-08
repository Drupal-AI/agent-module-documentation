<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base maps: the map_definition plugin type & SVG render pipeline

## The `map_definition` plugin type

A base map is a plugin, not an uploaded SVG. Discovery: attribute
`#[MapDefinition]` (`src/Attribute/MapDefinition.php`; legacy annotation in `src/Annotation/`),
namespace `Plugin/MapDefinition`, interface `MapDefinitionInterface`, base
`MapDefinitionPluginBase`, manager `MapDefinitionPluginManager` (service
`plugin.manager.map_definition`, alter hook `map_definition_info`).

Attribute fields: `id`, `label`, `description`, `uses_default_tooltip` (bool),
`default_tooltip` (string), `map_category` (UI grouping), `deriver`.

Interface: `label(): string` and `mapData(): array`. `MapDefinitionPluginBase::label()` casts the
translatable label; subclasses implement `mapData()`.

### `mapData()` return shape

Keyed by region id (e.g. state postal code). Each entry (from
`Plugin/MapDefinition/UnitedStates.php`, id `us_states_territories`):

```
'AK' => [
  'label' => 'Alaska',
  'svg-data' => ['paths' => [0 => 'M100.4,331.1C...Z']],   // one or more SVG path 'd' strings
  'text'    => ['text' => 'AK', 'x' => '91.86', 'y' => '303.31'], // optional region label glyph
],
```

`UnitedStates` holds 57 such regions (50 states + DC + territory hotspots) as a hard-coded private
array. Region ids and path data are shipped code, never request input.

## Merging config over plugin data — `MapDataLoader`

`src/MapDataLoader.php` (service `simple_interactive_maps.map_data_loader`).
`loadMapData(InteractiveMapInterface $map)`:

1. `createInstance($map->get('base_map'))->mapData()` → the raw region array.
2. `mergeConfigData()` `array_walk`s regions; for any region id present in `$map->getRegions()` it
   `array_merge`s the config overrides, then:
   - Resolves the action: if `action.plugin_id !== 'none'`, instantiates the `map_action` plugin
     with its `plugin_configuration` and replaces `action` with the plugin id +
     `action_configuration = $plugin->getActionConfiguration()`; else `action='none'`.
   - Applies group overrides via `applyGroupOverrides()` (colours / tooltip / action) when the
     region has a non-empty `group`.
   - Processes the tooltip: `tooltip['processed'] = renderProcessedText(value, format)` using
     `renderer->renderInIsolation(['#type' => 'processed_text', ...])` — i.e. run through the
     named text format's filters.

`getActionLibraries(map)` collects the unique `getActionLibrary()` of every region/group action
(static-cached per map id). `getMapOptions()` is a static helper listing all `interactive_map`
entities for select widgets.

## Building the SVG — `MapBuilder`

`src/MapBuilder.php` (service `simple_interactive_maps.map_builder`, uses `UseCacheBackendTrait`).
`getRenderHelper($map, $context)`:

- Cache id `simple_interactive_maps:map:<id>[:context]`, `cache.default`, tags = map cache tags;
  returns cached `MapRenderHelper` if present.
- Loads merged regions (above), fails fast if `base_map` plugin is gone.
- Builds an `svg` `#type html_tag` (namespaces, `preserveAspectRatio`, version) with a `<desc>` of
  the map label. Skips `hidden` regions.
- Per region: a `<g class="region action-<action> data-region-id=<id>">` containing one `<path>`
  per `svg-data.paths` entry (`d`, `fill`, `stroke`, `stroke-width`, `aria-label` = label), and,
  if `text` is set, a `<text>` glyph at `x`/`y` with inline `fill: <text_color>`.
- Collects the JS `settings[region_id]` = `{label, action{name,configuration}, style{fill/hover/
  stroke/text}, tooltip: processed}`.
- `viewBox` computed by `SvgHelper::calculateViewBox($allPaths)`.
- Dispatches `MapBuildEvent` (`Event/MapBuildEvent.php`, name; subscriber
  `EventSubscriber/MapBuildEventSubscriber`) so other modules can alter the render array/settings,
  then caches. `MapRenderHelper` (`src/MapRenderHelper.php`) just carries the render array + settings
  and can list required action libraries.

All region text (label, tooltip, glyph) reaches the page either as an html_tag `#attributes`/`#value`
(theme-escaped) or as filter-`processed_text` — no raw string concatenation into markup.

`hook_theme` (`simple_interactive_maps.module`) defines `interactive_map`,
`interactive_map_block`, `interactive_map_tools` (templates in `templates/`).
`simple_interactive_maps_preprocess_interactive_map()` calls `MapBuilder`, attaches the
`simple_interactive_maps/map-core` library + per-action libraries, and pushes the settings into
`drupalSettings.simple_interactive_maps[<map id>]`.

## SVG geometry — `SvgHelper`

`src/SvgHelper.php` (final, static). `getBoundingBox($path)` parses `M/L/H/V/C` path commands
(cubic Béziers via `calculateCubicBezierBoundingBox()`), `calculateViewBox($paths)` unions them into
the `viewBox` string. Pure math on shipped path data.

## Shipped & submodule base maps

- Core module: `us_states_territories` (US states + territory hotspots).
- `us_state_county_maps` submodule: 56 `*CountiesMap` plugins (`<state>_counties`,
  `map_category: 'US Census Bureau County Maps'`), one per state/territory.
- `congressional_districts_118` submodule: 52 `*CongressionalDistrictsMap` plugins
  (`<state>_congressional_districts`, `uses_default_tooltip: TRUE`,
  `map_category: 'US Census Bureau 118th Congressional District Maps'`).

Both submodules are documented in their own trees under `../../modules/`.
