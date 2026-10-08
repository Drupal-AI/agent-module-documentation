# The `workflow_modeler` plugin & model JSON

`src/Plugin/ModelerApiModeler/WorkflowModeler.php` is a **Modeler API** modeler plugin
(`#[Modeler(id: "workflow_modeler", label: "Workflow modeler")]`, extends `ModelerBase`). You do not
call it directly; Modeler API invokes it. This doc captures the model JSON shape and the plugin
contract so you need not read the ~600-line source.

## Dependency injection quirk

`ModelerBase` marks its constructor and `create()` **final** (to avoid circular deps — modeler_api
issue #3517655), so plugins use getter injection via `getContainer()`, not constructor injection.
`getFormToJsonConverter()` lazily fetches `FormToJsonConverter::class` this way.

## Model JSON document

`edit()`/`convert()` produce, and `parseData()` consume, a JSON object:

```json
{
  "id": "<model id>",
  "metadata": { "version": "1.0.0", "label": "New Model", "documentation": "",
                "executable": true, "template": false, "storage": "", "tags": [], "changelog": "" },
  "nodes": [ { "id": "...", "plugin": "<plugin_id>", "label": "...", "componentType": <int>,
               "position": {"x":100,"y":100}, "configuration": { ... }, "annotation": "optional" } ],
  "edges": [ { "id": "<source>_<target>", "source": "...", "target": "...",
               "condition": "<plugin_id>", "conditionConfiguration": { ... },
               "conditionLabel": "...", "conditionId": "...", "annotation": "optional" } ]
}
```

- **Component type** is the integer `componentType` (`Api::COMPONENT_TYPE_*`: element / link /
  annotation / …); a legacy string `type` is resolved via `Api::COMPONENT_TYPE_NAMES`.
- **Edges** carrying a `condition` become `COMPONENT_TYPE_LINK` components; `conditionId` is
  preserved for round-trip stability, else derived as `<edgeId>_condition`.
- **Parallel edges** (same source+target) keep `"{source}_{target}"` for the first and append
  `_<n>` for subsequent ones.
- **Annotations** on a node/edge become `COMPONENT_TYPE_ANNOTATION` components whose successor points
  back at the annotated element.
- `false` boolean configuration values are stripped before building components (they fall back to
  plugin defaults).

## Plugin method contract (what each override does)

- `convert(owner, model, readOnly)` — rebuild JSON from a saved model entity: iterate
  `$owner->getUsedComponents()`, collect link/condition components first, then build `nodes` and
  `edges` (with condition + annotation data), and hand off to `edit()`.
- `edit(owner, id, data, isNew, readOnly)` — build the render array: attach `modeler/react-ui` and
  `drupalSettings.modeler` = `{ modelId, modelData, components, typeMap }`. In non-readonly mode the
  `components` palette is every `availableOwnerComponents()` per supported type (with
  `documentationUrl`).
- `parseData(owner, data)` — decode posted JSON into `modeler_api` `Component` /
  `ComponentSuccessor` objects; also extracts `metadata`.
- `configForm(owner)` — JSON endpoint: reads `{component_type, model_id, is_new, plugin_id,
  configuration}` from the request body, builds the owner's config form for that plugin, wraps it via
  `Wrapper`, and returns `FormToJsonConverter->convert($form, $schemaKey)` (schema key from
  `$owner->getPluginSchemaKey()`). Returns `{error: ...}` on invalid/non-editable input.
- `prepareEmptyModelData(&$id)` — generate an id and an empty model skeleton.
- Metadata accessors (`getId/getLabel/getTags/getChangelog/getTemplate/getStorage/getDocumentation/
  getStatus/getVersion`) read `$this->metadata`; `enable()/disable()/clone()` mutate it and call
  `rebuildRawData()` to re-sync the raw JSON.

## Request query parameters honoured by `edit()`

- `select` → `drupalSettings.modeler.selectComponentId` (preselect/deep-link a node).
- `context`, `contextConfig` (JSON, array only) → `selectContextId` / `setContextConfig` (non-readonly).
- `hash` → `replayData` via `$owner->getReplayData($hash)` (execution replay).
- `HX-Request` header present → `stayInContextOnClose = true`.

## Backend services (call from your own code if needed)

- `modeler.form_to_json_converter` (`Drupal\modeler\FormToJsonConverter`, FQCN alias) —
  `convert($form, $schemaKey)` serialises a Drupal form array to the JSON the React property panel
  renders.
- `modeler.yaml_schema_lookup` (`Drupal\modeler\YamlSchemaLookup`, FQCN alias) — resolves typed-config
  schema for a key so YAML textarea fields get schema-aware editing.

## Writing your own modeler plugin

You do not subclass this; instead implement Modeler API's `ModelerBase` in your module with a
`#[Modeler(...)]` attribute and provide your own `convert`/`edit`/`parseData`. This module is the
reference React implementation.
