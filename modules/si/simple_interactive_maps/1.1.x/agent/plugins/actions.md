<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Click behaviours: the map_action plugin type & shipped actions

## The `map_action` plugin type

Discovery: attribute `#[MapAction]` (`src/Attribute/MapAction.php`; annotation in `src/Annotation/`),
namespace `Plugin/MapAction`, interface `MapActionInterface`, base `MapActionPluginBase`
(implements `PluginFormInterface` + `ConfigurableInterface`), manager `MapActionPluginManager`
(service `plugin.manager.map_action`, alter hook `map_action_info`).

Attribute fields: `id`, `label`, `description`, `is_system` (hide from the UI), `weight`, `deriver`.

Interface methods: `label()`, `isSystem()`, `getActionLibrary()` (Drupal library machine name),
`getActionConfiguration()` (config prepared for the JS client). Plugins also implement the standard
`buildConfigurationForm()/validate/submit` and `defaultConfiguration()`.

An action is attached to a region (or group) as `action: {plugin_id, plugin_configuration}` in the
`interactive_map` entity. At render time `MapDataLoader` instantiates the plugin, so the JS receives
`getActionConfiguration()` under `drupalSettings.simple_interactive_maps[map][region].action`.
`MapRenderHelper::getActionLibraries()` / `MapDataLoader::getActionLibraries()` collect each action's
`getActionLibrary()` so only used behaviours are attached.

The client dispatcher (`js/simple_interactive_maps.js`, library `simple_interactive_maps/map-core`)
wires each region `<g>` to `Drupal.simple_interactive_maps[<action name>](elem, config, region)`.

## Shipped actions (`src/Plugin/MapAction/`)

- **`none`** — `NoneAction.php`. `is_system: TRUE`, `weight: -100`. No config. Library
  `simple_interactive_maps/no_action`; JS sets `role="presentation"`. Regions default to this.
- **`navigate_action`** — `NavigateAction.php`, label "Navigate to URL". Config `url` (required)
  + `new_tab` (bool). `validateConfigurationForm()` rejects a URL that fails `parse_url()`. Library
  `navigate_action`; JS (`map.action.navigate.js`) on click does `window.open(url)` (new tab) or
  `window.location.href = url`, and sets `role="link"`.
- **`modal_content`** — `ModalContentAction.php`, label "Display Modal Content". Config
  `modal_content {value, format}` (a `text_format` field, default format `basic_html`).
  `getActionConfiguration()` returns the **filter-processed** HTML (`renderer->renderInIsolation`
  of `#type processed_text`). Library `modal_content`; JS (`map.action.modal-content.js`) opens a
  `Drupal.dialog(...).showModal()` titled with the region label, and sets `role="button"`.
- **`ajax_load_map`** — `LoadMap.php`, label "Load Map". Config `target_map_id` (a select of all
  maps via `MapDataLoader::getMapOptions()`). Library `load_map`; JS (`map.action.load-map.js`)
  POSTs `map_to_load`/`target_element` to `Drupal.url('simple-interactive-maps/ajax')`
  (`AjaxMapLoaderController`, see embedding/embed.md), replacing the current map and maintaining a
  global `window.simBackLinks` "Back to previous map" stack.

Modal/tooltip bodies are only as restrictive as the text format an administrator chooses for them;
they are configured under `administer interactive_map`.

## Adding a custom action

Create `src/Plugin/MapAction/MyAction.php` extending `MapActionPluginBase` with a `#[MapAction]`
attribute, implement `defaultConfiguration()`, the form methods, `getActionLibrary()` (declare the
JS in `*.libraries.yml`, depending on `simple_interactive_maps/map-core`), and
`getActionConfiguration()`. Register `Drupal.simple_interactive_maps.<id> = function(elem, config,
region){…}` in that library's JS.
