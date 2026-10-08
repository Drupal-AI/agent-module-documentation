# Configure / use the BPMN.iO modeler

bpmn_io has **no settings form, no permissions, and no config of its own**
(`configure` is `null`). You configure it indirectly, through a modeler_api
**model owner** module (e.g. ECA, AI Agents).

## Enable

```bash
composer require drupal/bpmn_io   # pulls drupal/modeler_api
drush en bpmn_io -y
```

## Select it as a model owner's modeler

modeler_api lets each model-owner module choose which Modeler plugin edits its
entities. bpmn_io registers itself with plugin id **`bpmn_io`** (label "BPMN.iO").
Where a model owner exposes a modeler choice (ECA / AI Agents settings), pick
`bpmn_io`. There is no bpmn_io-specific route — editing happens on the owner's
edit route, which renders the modeler's `edit()` render array (canvas + toolbar +
off-canvas property panel).

## Theme requirement

The modeler only renders under **Claro** or **Gin** (or a subtheme of either).
Under any other active admin theme the user sees a warning
("The BPMN.iO modeler is not supported in the current theme.") and the editor
may not work. Whitelist another theme with the alter hook (see api doc):

```php
function mymodule_bpmn_io_supported_themes_alter(array &$supported_themes): void {
  $supported_themes[] = 'my_gin_subtheme';
}
```

## In the editor (toolbar widgets)

The canvas toolbar exposes: model **info**, **auto-layout**, **download SVG**,
**copy**/**paste**, **zoom in/out/fit**, element **search**, and a **minimap**.
Clicking any element opens an off-canvas properties panel built from the owner
plugin's own configuration form. Toolbar glyphs come from the module's `bpmn_io`
icon pack (Icon API).

## Model-level data

Executable status, tags, version, changelog and documentation are stored inside
the BPMN XML (process `isExecutable` attribute and Camunda-style extension
properties) and surfaced/edited via the modeler, not via Drupal config.
