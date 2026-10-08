# Services, convert flow, libraries & theme hook

## Services (`bpmn_io.services.yml`)

- **`bpmn_io.parser`** (`Drupal\bpmn_io\Service\Parser`) — parses/serializes BPMN
  2.0 XML. `setData($owner, $xml)` loads XML (via `mtownsend/xml-to-array` + DOM),
  `getComponents()` returns modeler_api `Component[]` (sequence flows, gateways,
  start events, tasks, subprocesses, annotations, participants, colors),
  `updateComponents($owner, $templates)` writes template property/field bindings
  back into the DOM, and `enable()/disable()/clone()` toggle the process
  `isExecutable` attribute or rewrite its id/label. Model metadata getters read
  Camunda extension properties (`getTags`, `getChangelog`, `getVersion`,
  `getStorage`, `getDocumentation`, `getTemplate`, `getStatus`). BPMN namespace
  prefix used is `bpmn2:`.
- **`bpmn_io.prepare_components`** (`Drupal\bpmn_io\Service\PrepareComponents`) —
  builds bpmn-js element templates from owner plugins (`getTemplates()`), and
  helpers `sanitizeConfigValue()` / `upcastConfiguration()` that convert between
  Drupal config value types and the string form stored in BPMN XML.

These services are internal plumbing for the Modeler plugin; call the plugin
(via modeler_api) rather than the parser directly in most cases.

## `convert` client flow

`BpmnIo::convert()` is used to migrate an owner config entity that has no diagram
yet. It renders an empty model, then attaches
`drupalSettings.bpmn_io_convert` (metadata + `elements`, `annotations`, `colors`,
`bpmn_mapping`, `template_mapping`) and the `bpmn_io/convert` library
(`js/bpmn_io.convert.js`) which lays the components out on the canvas and can
redirect back to the entity edit URL when done.

## Libraries (`bpmn_io.libraries.yml`)

- **`bpmn_io/core`** — the bundled bpmn-js editor (`js/bpmn-modeler.js`,
  v13.2.2, MIT, from github.com/bpmn-io/bpmn-js) plus its CSS (diagram-js,
  properties-panel, minimap, color-picker, element-templates, bpmn-font).
- **`bpmn_io/ui`** — `js/bpmn_io.js` + `css/bpmn_io.css`; depends on `core`,
  `drupal.ajax`, `drupal.message`, `drupalSettings`, `jquery`. Attached by `edit()`.
- **`bpmn_io/convert`** — `js/bpmn_io.convert.js`; depends on `ui` and `core/once`.

## Icon pack (`bpmn_io.icons.yml`)

Registers a `bpmn_io` Icon API pack (SVG extractor, sources `icons/*.svg`,
MingCute set) used for the toolbar widget glyphs referenced as
`#type => icon, #pack_id => 'bpmn_io', #icon_id => '…'`.

## Hook (`bpmn_io.api.php`)

```php
/**
 * Alter the themes under which the BPMN.iO modeler is allowed to render.
 * Defaults: ['claro', 'gin'].
 */
function hook_bpmn_io_supported_themes_alter(array &$supported_themes): void {
  $supported_themes[] = 'my_custom_theme';
}
```

Invoked by `BpmnIo::sanityCheckTheme()`; if the active theme (or its base theme)
is not in the list, the user gets a warning that the modeler is unsupported.
