<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field, forms, storage & value computation

How the module surfaces options and where values live. All source in
`entity_options.module` and `src/`.

## Computed field (node only)

`entity_options_entity_base_field_info()` adds base field **`entity_options`** to the `node`
entity type only: field type `entity_options_map`, translatable, **computed**, custom storage,
list class `EntityOptionsItemList`, form display type `entity_options` (region `hidden` by
default, display-configurable). No other entity type gets it.

- `EntityOptionsItem` (`src/Plugin/Field/FieldType/EntityOptionsItem.php`, `@FieldType id =
  entity_options_map`, `no_ui = TRUE`, default widget `entity_options`) extends core `MapItem`.
  On first access (`__get`/`isEmpty`/`getValue`) `ensureCalculated()` calls
  `plugin.manager.entity_options->computeValue()` and `setValue()`s the result (catching
  `ReadOnlyException` and logging a warning).
- `EntityOptionsItemList` (`ComputedItemListTrait` + core `MapFieldItemList`) forces a single
  item (`computeValue()` → `ensurePopulated()`).

## Node-type form (bundle defaults)

`Plugin/FormAlter/EntityOptionsFormAlter` is a `pluginformalter` `@FormAlter` on base form
`node_type_form`. `formAlter()`:
- builds a details group **"Entity Options"** under `additional_settings`; for each option from
  `getTypeOptions($bundle)` adds an **Enable** checkbox (`configuration['status']`), the plugin's
  `settingsForm()` elements (for parametric options), and — when `allowsOverrides()` — an
  **"Allow per node overrides"** checkbox (`configuration['overrides']`). Flag options show a
  "This option is a flag option." note.
- Prepends `EntityOptionsFormAlter::formAlterNodeTypeFormSubmit` to the submit handlers; it writes
  each submitted option array into the node type via `setThirdPartySetting('entity_options', $key,
  $value)`.

## Node form (per-node overrides)

`Plugin/Field/FieldWidget/EntityOptionsWidget` (`@FieldWidget id = entity_options`,
`multiple_values = FALSE`). `formElement()` shows **only** options where
`allowsOverrides() && getOverride()` are both true; renders a checkbox for flags or the plugin's
`settingsForm()` for parametric options, grouped into the form's `advanced` sidebar (weight 30)
when present. If no such options exist it returns the element unchanged.

## Storage & value computation (`Service\EntityOptionsPluginManager`)

- Bundle defaults live in the **node type third-party settings** (`entity_options.*`).
- Per-node overrides live in the **key-value store**, collection
  `entity_options.<entity_type>.<bundle>` (`getCollection()`), entry key = entity id, or
  `Crypt::hashBase64($id)` for non-ASCII / >128-char ids (`getEntityOptionsStoreKey()`).
- `entity_options.module` hooks: `hook_entity_insert`/`hook_entity_update` →
  `updateEntityOptions()` (writes `$entity->entity_options` first item to key-value);
  `hook_entity_delete` → `purgeEntityOptions()` (deletes the entry). Both guard on
  `hasEntityOptionsField()` (content entity with an `entity_options_map` field).
- `computeValue(EntityInterface $entity, ?array $value)`: resolves the bundle, then for each
  option merges the per-node value over the default **only** when `allowsOverrides()` &&
  `getOverride()` && a stored value exists; otherwise returns the default (flag → `getStatus()`
  bool, parametric → `getConfiguration()`). Disabled non-overridable options resolve to `FALSE`
  (flag) or `NULL` (parametric). Type-mismatched stored values fall back to the default; arrays
  are merged with `array_replace_recursive`, scalars replaced. New entities compute with an empty
  override set.
- Enumeration helpers: `getTypeOptions(ConfigEntityInterface $type)` instantiates every option
  with the bundle's third-party settings; `getTypeOption($id, $type)` returns one.

## Consuming values

Read merged values from the computed field: `$node->entity_options` (first item value is a keyed
array of `option_id => value`). Alter available options via `hook_entity_options_info(&$defs)`.
