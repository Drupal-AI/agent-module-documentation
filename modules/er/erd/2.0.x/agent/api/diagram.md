<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the diagram is built, its data contract, and the alter hook

`EntityRelationshipDiagramController::getMainDiagram()` (route `erd.admin`) renders a small
static toolbar plus an empty `.erd-container` and attaches the `erd/main` library with all the
model data in `drupalSettings.erd`. The actual drawing is done client-side by `js/main.js` using
JointJS. Nothing about the model is stored server-side except a saved *layout* (see State below).

## How metadata is gathered (`getMainDiagram`)

Injected services: `entity_type.manager`, `entity_field.manager`, `entity_type.bundle.info`,
`module_handler`, `config.factory`, `state`.

1. Iterate `entityTypeManager->getDefinitions()`. Each entity type becomes an `entities[]` node
   (`type: 'type'`, label from `$definition->getLabel()`).
2. For each bundle from `entityTypeBundleInfo->getBundleInfo($definition_id)`, add a
   `type: 'bundle'` node (identifier `"{entity_type}:{bundle}"`). If the type has a bundle entity
   type, add an "Is a bundle of" link.
3. For **fieldable** types (`entityClassImplements(FieldableEntityInterface::class)`), walk
   `entityFieldManager->getFieldDefinitions()`, applying the `erd.settings` filters
   (`field_exclude`, `property_include`, `entity_reference_only` — see
   [configure/settings.md](../configure/settings.md)). Each surviving field becomes an attribute
   on the bundle node. Reference edges are added when the field's item list implements
   `EntityReferenceFieldItemListInterface` (targets resolved from
   `handler_settings.target_bundles`, or every bundle of the target type if unset) and when the
   field type is `comment` (targets `comment` / the configured `comment_type`). Cardinality is
   rendered as `[min..max]` (`max` = `many` for unlimited).
4. For **config entity** types, export non-internal properties from `getPropertiesToExport()`
   (skips `_core`, `third_party_settings`, `dependencies`, `status`).
5. `moduleHandler->alter('erd_entities', $entities)` is invoked (see below).

The result is a render array whose `#markup` is a fixed toolbar (`#allowed_tags` limited to
`input`, `div`, `i`; no user data is interpolated into it) and whose `#attached.drupalSettings`
carries the model.

## `drupalSettings.erd` contract (consumed by `js/main.js`)

| Key | Shape | Notes |
|-----|-------|-------|
| `entities` | array of `{identifier, id, type: 'type'\|'bundle', type_label, label, entity_type_label?, fields?}` | Nodes offered in the autocomplete / placed on the canvas. |
| `links` | array of `{label, cardinality?, from, from_selector?, targets: string[]}` | Reference / bundle / comment edges; `targets` are node identifiers. |
| `settings` | `{output_format}` | Drives the client "Save to image" button. |
| `graphState` | JSON string or null | The last saved layout (see State). `main.js` does `JSON.parse` then `graph.fromJSON`. |

All labels and field names are escaped with `Drupal.checkPlain()` in `main.js` before being set
as JointJS SVG `<text>` content, so entity/field labels are rendered as text, not markup.

## Layout persistence — State, not config

`erd.ajaxSave` (`/admin/structure/erd/ajax`, `::saveDiagram`) stores the request body verbatim
into the State key `erd.graph`:

```php
$this->state->set('erd.graph', $request->getContent());
```

`main.js` POSTs `graph.toJSON()` there on every graph change and re-hydrates it from
`drupalSettings.erd.graphState` on the next load. It is a single global layout (not per-user),
kept in State (not exportable config). Clear it with `drush state:delete erd.graph`.

## Extending the diagram — `hook_erd_entities_alter()`

The only integration hook. Implement it to add, remove, or modify nodes before rendering:

```php
/**
 * Alter the ERD node list before it is sent to drupalSettings.
 *
 * @param array $entities
 *   Array of node arrays (see the entities contract above). Add nodes with
 *   'identifier', 'id', 'type' ('type'|'bundle'), 'type_label', 'label', and
 *   optional 'fields'; edges are derived on the client from 'links', which this
 *   hook does not receive, so use it for presentational node changes.
 */
function mymodule_erd_entities_alter(array &$entities) {
  foreach ($entities as &$node) {
    if ($node['identifier'] === 'node') {
      $node['label'] = $node['label'] . ' (content)';
    }
  }
}
```
