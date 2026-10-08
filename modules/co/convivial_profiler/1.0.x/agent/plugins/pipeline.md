<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The source → processor → destination pipeline (convivial_profiler)

A "profiler" is an ordered list of three plugin stages. The Drupal side only builds and stores the
selected plugin IDs plus their form values; the **external SDK executes them in the browser**.

## Three plugin types

Discovered by `ProfilerPluginManagerBase` (`src/Plugin/ProfilerPluginManagerBase.php`) which stacks
`AttributeDiscoveryWithAnnotations` + `YamlDiscoveryDecorator` + `ContainerDerivativeDiscoveryDecorator`,
so definitions come from a per-type YAML file **and** PHP attribute/annotation classes. Each manager
(`ProfilerSourcePluginManager` etc.) sets `pluginType`, interface, annotation, attribute, and a
`defaults` array whose `class` is the matching `*Default` plugin. Managers are the services
`plugin.manager.profiler_{source,processor,destination}` (parent `default_plugin_manager`,
arg `@theme_handler`; alter hook `convivial_profiler_profiler_<type>_info`).

- **Sources** (`convivial_profiler.profiler_source.yml`): `acceptlang` (navigator.language),
  `cookie` (by name), `get` (page URL / resource_url), `httpuseragent` (navigator.userAgent),
  `meta` (HTML meta tag by name), `query` (URL query param), `time` (hour/minute/second).
- **Processors** (`convivial_profiler.profiler_processor.yml`): `accumulation`, `dimension`,
  `extreme_geoip` (async **GeoIP service lookup**, performed client-side by the SDK), `language_full`,
  `language_simple`, `map` (pipe-delimited value→key mappings), `pageview` (track/log),
  `logger`, `searchquery`, `store` (with TTL), `unstore_value`, `temp`.
- **Destinations** (`convivial_profiler.profiler_destination.yml`): `bestpick`, `copy`,
  `datalayer_event` (**pushes to GTM dataLayer**), `flag`, `formfiller` (fills form fields from the
  profile), `formtracker` (tracks form responses to dataLayer), `officehours`, `range`, `remove`,
  `season`, `set`, `threshold`, `top`, `tops`, `unset`. Most write to a target `cookie` and/or
  `localstorage` location.

Each YAML entry is `label`, `description`, and a `form` render-array fragment describing the config
fields (textfields, checkboxes, selects, textareas — e.g. `storage_key`, `target_key`, `ttl`,
`mappings`, `ranges`, `office_times`). The schema for every possible key is enumerated under
`profilers.*.{sources,processors,destinations}` in `config/schema/convivial_profiler.schema.yml`.

## Building a profiler (admin UI)

- `ProfilerListForm` (`convivial_profiler.list`, id `convivial_profiler_list_form`) — a draggable
  table of existing profilers; label/name/status/description rendered with `#plain_text`; save
  persists only the reordered `weight`s.
- `ProfilerAddForm` — captures label, machine `name`, weight, status, deferred, description; seeds
  empty `sources`/`processors`/`destinations`; writes `profilers.<name>` and redirects to edit.
- `ProfilerEditForm` (`src/Form/ProfilerEditForm.php`, `@internal`) — the real builder. Injects the
  three managers, calls `getDefinitions()` once, and `buildDraggable()` renders a details+table per
  stage with per-row **AJAX** Add/Edit/Save/Delete buttons. `buildItem()` does
  `$manager->createInstance($item['type'], $item)->buildConfigurationForm()` so each plugin renders
  its own subform; `saveItemSubmit()` runs the plugin's `validate`/`submit` and writes
  `profilers.<id>.<type>s.<key>` = `$plugin->getConfiguration()`; `deleteItemSubmit()` clears that
  key. Base fields (label/status/deferred/description) are saved in `submitForm()`. A missing
  `profiler_id` throws `NotFoundHttpException`.
- `ProfilerDeleteForm` (`convivial_profiler.profiler_delete`) — confirm-form delete.

All five forms require **`administer convivial profiler`**; edits are standard Drupal
form-API/AJAX submits (CSRF-protected) writing to the config object — there is no separate
data-ingestion path.

## Extending the palette

Provide a new step by adding a `<module>.profiler_source.yml` (or processor/destination) entry, or a
PHP class carrying `#[ProfilerSource]` (`src/Attribute/…`) / `@ProfilerSource` (`src/Annotation/…`)
implementing the matching `Profiler*Interface`. Adjust existing definitions with
`hook_convivial_profiler_profiler_source_info_alter(&$plugins)` and the processor/destination
variants (see `convivial_profiler.api.php`) — you may override `class`, `label`, etc.
