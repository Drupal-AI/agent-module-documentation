<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin: Entity Browser in the link UI

Class `Drupal\ckeditor5_entity_browser\Plugin\CKEditor5Plugin\CkeditorEntityBrowser`
(`src/Plugin/CKEditor5Plugin/CkeditorEntityBrowser.php`). Extends `CKEditor5PluginDefault`,
implements `CKEditor5PluginConfigurableInterface` (+ `CKEditor5PluginConfigurableTrait`).

## Declaration (`ckeditor5_entity_browser.ckeditor5.yml`)

- Plugin id `ckeditor5_entity_browser_linkui_entity_browser`; JS plugin
  `linkui_entity_browser.LinkUIEntityBrowser` (built into `js/build/linkui_entity_browser.js`).
- `drupal.label: Entity Browser`, `library: ckeditor5_entity_browser/ckeditor5`, `elements: false`
  (adds no schema elements — it only writes the link URL).
- `conditions.plugins: [ckeditor5_link ]` — only available when core's **Link** plugin is enabled;
  the buttons render inside the link balloon, not as standalone toolbar items.

## Install / enable

1. `drush en entity_browser ckeditor5_entity_browser` (core `ckeditor5` is a dependency).
2. Build at least one **Entity Browser** (a View with a bulk-select form). README recommends turning
   on *Use field cardinality* so the browser shows radio buttons (single select).
3. Edit a **text format** whose editor is CKEditor 5 (`/admin/config/content/formats/manage/<id>`).
   The Link toolbar item must be present. The plugin's settings appear in the CKEditor 5 plugin
   settings area; enable the desired browser(s).

## Settings & config storage

Stored on the `editor` config entity under
`settings.plugins.ckeditor5_entity_browser_linkui_entity_browser`. Two keys:

- `entity_browser_enabled` (boolean) — `defaultConfiguration()` returns `FALSE`.
- `enabled_entity_browsers` (sequence of entity_browser ids).

`buildConfigurationForm()` loads all `entity_browser` entities and renders one checkbox per browser.
`validateConfigurationForm()` collapses the checkbox values to a compact array of ids.
`submitConfigurationForm()` sets `entity_browser_enabled = !!$enabled_entity_browsers` and stores the
selected ids only when enabled.

## Config schema & validation (`config/schema/ckeditor5_entity_browser.schema.yml`)

Type `ckeditor5.plugin.ckeditor5_entity_browser_linkui_entity_browser`:

- `entity_browser_enabled: boolean`.
- `enabled_entity_browsers: sequence` of `string`, each constrained by a **`Choice`** whose callback
  is `CkeditorEntityBrowser::validChoices()` (returns the ids of all existing `entity_browser`
  entities) — so an unknown browser id fails validation.
- A **`Callback` constraint** `CkeditorEntityBrowser::requireEntityBrowserIfEnabled()` on the whole
  mapping: errors if enabled with no browsers selected, or disabled while browsers are still
  associated.

## Runtime config sent to the editor — `getDynamicPluginConfig()`

For each enabled browser it builds a per-browser config entry and returns it under
`['entity_browsers' => $config]` (drupalSettings for the JS plugin). Per entry:

- Skips browsers whose display is not a `DisplayRouterInterface` (needs a routed/path display).
- `widget_context.cardinality = 1`, `label` = *"Select content"*, ascending `weight`,
  `browser_display_url` = the display's `path()`, `original_path` = the current page path.
- Fires `hook_ckeditor5_entity_browser_definitions_alter($config)` so modules can change label,
  weight or widget context (see [../api/selection-flow.md](../api/selection-flow.md)).
- Then, per browser, generates a fresh **UUID**, marks `ckeditor => TRUE`, and writes the entry into
  Entity Browser's `entity_browser.selection_storage` via `setWithExpire($uuid, …, 21600)` (6 h).
  That UUID is the handshake the `.module` form-alter keys off to recognise a CKEditor-launched
  browser.

## What gets inserted

Selection resolves (in the `.module` AJAX callback) to `'/' . $entity->toUrl()->getInternalPath()`
— a **resolved canonical path** (e.g. `/node/5`), not an entity reference. Only entities exposing a
`canonical` link template qualify; a single selection is enforced. No new permissions, routes,
services, or Drush commands are added by this plugin.
