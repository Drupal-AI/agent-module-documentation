# Canvas hooks (`canvas.api.php`)

Two documented hooks. (Managers also fire alter hooks — `canvas_component_source`,
`canvas_extension_info`, `canvas_adapter_manager_info` — for plugin definitions; see
[../plugins/plugins.md](../plugins/plugins.md).)

## `hook_canvas_storable_prop_shape_alter(CandidateStorablePropShape $storable_prop_shape): void`
Override how a component prop's JSON-Schema **shape** is stored — i.e. which Drupal field
type + widget + instance settings back a given prop shape (the "shape matching" pipeline).
Mutate the passed `$storable_prop_shape` object:
- `->fieldWidget` — set the widget id (e.g. `'options_buttons'`, `'link_default'`).
- `->fieldTypeProp` — a `StructuredData…PropExpression` choosing the field type + property
  (e.g. `StructuredDataPropExpression::fromString('ℹ︎link␟url')`).
- `->fieldInstanceSettings` — field instance settings array (e.g. media `target_bundles`).
- `->shape->schema` — the JSON Schema being matched (read to branch on `type`/`format`/`enum`/`$ref`).

Typical uses: map `{type:string, format:uri}` to the `link` field instead of `uri`; add a
contrib field type for an otherwise-unsupported shape (`format: duration`); include/exclude
media bundles for the `image` object ref. Any widget used must declare `canvas.transforms`
on its plugin definition. See `docs/shape-matching.md`.

## `hook_canvas_importmap_alter(array &$import_maps): void`
Add/remove/modify entries of the JS **import map** used by Canvas code components, following
the standard import-map spec:
- `$import_maps['imports']` — global `specifier => URL` map.
- `$import_maps['scopes']` — optional `scopeURL => (specifier => URL)`.

Cache-busting query strings are appended to global imports after this hook runs. Backed by
`\Drupal\canvas\GlobalImports::getImportMap()`.
