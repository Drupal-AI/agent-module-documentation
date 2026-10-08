<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shape matching, annotations, Twig & the auto-create endpoint

## Prop-shape pipeline

`EntityReferenceHooks::storablePropShapeAlter()` implements
`hook_canvas_storable_prop_shape_alter`. It calls
`EntityReferenceShapeMatcher::matches()` and, on a match, `apply()`.

`matches()` (returns bool) — matches when the schema (root, or `items` for `type: array`) has:

- a `$ref` present in `EntityReferenceConstants::REF_URI_TO_ENTITY_TYPE`, **or**
- an `x-entity-type` key.

`apply()` mutates the `CandidateStorablePropShape` in place:

- `resolveEntityTypeId($schema)` → entity type from `$ref` map, else `x-entity-type`, else default
  `taxonomy_term`. Unrecognised array-item `$ref`s are logged as a warning.
- `resolveFieldKey($schema, $type)` → `x-entity-field` if set, else the entity type's `label` key
  via `EntityTypeManager::getDefinition()->getKey('label')` (fallback `name`).
- Builds the prop expression `ℹ︎entity_reference␟entity␜␜entity:{type}␝{field}␞␟value` →
  `ReferenceFieldTypePropExpression::fromString()`.
- `fieldStorageSettings = ['target_type' => $type]`.
- `fieldInstanceSettings` from `buildInstanceSettings()`: handler `default:{type}`. For non-taxonomy
  types, only `target_bundles` (from schema) if present. For `taxonomy_term`: `auto_create`
  (config, default TRUE), `target_bundles` (schema `x-entity-type-bundles` wins over global config),
  and `auto_create_bundle` = first target/available bundle when auto-create is on.
- Widget: array → `x-entity-widget` else `entity_reference_autocomplete_tags`; single → `x-entity-widget`
  else config `widget` else `entity_reference_autocomplete`.
- Cardinality: tags widget → always `CARDINALITY_UNLIMITED` (tags render one input; `maxItems` is
  enforced by JSON Schema, not field cardinality); other array widgets → `maxItems` or unlimited.
- Adds the config object as a cacheable dependency.

`resolveBundlesFromSchema()` / `resolveTargetBundles()` accept a comma-string or array, `trim` each,
validate against registered bundles (`entity_type.bundle.info`), drop invalid, return NULL
(unrestricted) when none valid.

## Annotations (declared in a component `.component.yml` prop schema)

- `x-entity-type: <entity_type_id>` — which entity type (taxonomy_term, node, user, media,
  block_content, or any other). Or legacy `$ref: json-schema-definitions://canvas_entity_reference.module/<type>-reference`.
- `x-entity-field: <field>` — which value to expose (e.g. `nid`/`tid`/`uid`/`mid` for a numeric ID,
  or `title`/`name`). Defaults to the entity label key.
- `x-entity-type-bundles: 'a, b'` or `['a','b']` — restrict selectable bundles (all types; for
  taxonomy overrides the global vocabulary setting).
- `x-entity-widget: <widget_plugin_id>` — per-prop widget override; the widget must have Canvas
  transform metadata via `hook_field_widget_info_alter()`.

`schema.json` `$defs`: `taxonomy-term-reference`, `node-reference`, `user-reference`,
`media-reference`, `block-content-reference` — each a `type: string` with the matching
`x-entity-type`. Keep in sync with `REF_URI_TO_ENTITY_TYPE`.

## Widget transform metadata

`EntityReferenceHooks::fieldWidgetInfoAlter()` registers, under each widget's `['canvas']['transforms']`:

- `entity_reference_autocomplete` → `entityReferenceAutocomplete` + `firstRecord` +
  `mainProperty` (`target_id`) — extracts one numeric ID from the `Label (ID)` string.
- `entity_reference_autocomplete_tags` → `entityReferenceAutocomplete` with `multi: true` — returns
  a flat array of numeric IDs.

Library `canvas.transform.entityReferenceAutocomplete` ships `js/entity-reference-autocomplete-transform.js`.
The two `*_form_alter` hooks call `attachAutoCreateBehavior()`, which (when `auto_create` is on)
attaches library `canvas_entity_reference/auto_create` + `data-canvas-entity-ref-auto-create="true"`
on the `target_id` input, and always adds a `_canvas_ref_sentinel` hidden field so Canvas keeps the
readable `Label (ID)` display while transforms still run on save/preview.

## Twig `entity_render()`

`EntityRenderExtension` (twig.extension service) provides
`entity_render(string $entity_type, int|string|null $entity_id, string $view_mode = 'default')`
(`is_safe: html`). `renderEntity()`: returns `''` for empty id; loads via storage, returns `''` if
NULL **or `!$entity->access('view')`**; otherwise renders through the entity view builder and
returns the string; any `\Exception` → `''`. Use with `x-entity-field: mid` (etc.) to pass a numeric
ID from a prop:

```twig
{% if hero_image > 0 %}{{ entity_render('media', hero_image, 'default') }}{% endif %}
```

## Auto-create endpoint

`AutoCreateTermController::resolveTerm()` — POST `/api/canvas-entity-reference/create-term`, route
perm `access content` + `_csrf_token: TRUE`. Steps:

1. Return 403 if config `auto_create` is off.
2. `name` = trimmed POST `name`; 400 if empty, 400 if `mb_strlen > 255`.
3. `resolveVocabulary()`: first valid configured `target_bundles` vocabulary, else first available;
   422 if none.
4. **Require `administer taxonomy` or `edit terms in <vocab>`** — else 403.
5. `loadByProperties(name, vid)`; reuse existing term or `create()`+`save()` a new one.
6. JSON `{ tid, name }`.

The JS (`js/entity-reference-auto-create.js`) fetches `/session/token` for the CSRF header and POSTs
each unresolved comma-segment on blur, then rewrites the input to `Name (ID)`.
