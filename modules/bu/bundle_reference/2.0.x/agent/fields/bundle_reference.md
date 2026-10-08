<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bundle_reference` field type, widget and formatter

## Install & enable

```bash
composer require drupal/bundle_reference
drush en bundle_reference -y
```

No dependencies beyond Drupal core. No submodules, no permissions, no Drush commands, no
configuration routes. Nothing to configure globally — everything is per-field.

## The field type

`src/Plugin/Field/FieldType/BundleReferenceItem.php` — id **`bundle_reference`**, label
*"Bundle reference"*, category *"Reference"*, `default_widget = bundle_reference_widget`,
`default_formatter = bundle_reference_formatter`.

Storage (`schema()`), two nullable columns:

| Column | Type | Notes |
|---|---|---|
| `entity_type` | `varchar(255)` | Entity type ID, e.g. `node`. |
| `bundle` | `varchar(255)` | Bundle machine name, e.g. `article`. |

Properties (`propertyDefinitions()`): `entity_type` (string, "Entity type ID") and `bundle`
(string, "Bundle ID"). `isEmpty()` returns true when the **`bundle`** value is empty (an
entity_type with no bundle still counts as empty).

A field value therefore records *which type of thing* (e.g. `node:article`), not a specific
entity — no target entity is ever loaded.

## Field settings — `referencable_bundles`

`defaultFieldSettings()` → `['referencable_bundles' => []]`. `fieldSettingsForm()` renders a
`checkboxes` element titled *"Referencable bundles"* whose options come from
`getBundleOptions()`:

- iterates `\Drupal::service('entity_type.bundle.info')->getAllBundleInfo()`;
- keeps only entity types whose definition is a `ContentEntityTypeInterface`;
- each option key is `"{entity_type_id}:{bundle_id}"`, label `"{EntityLabel}: {BundleLabel}"`.

`fieldSettingsToConfigData()` unsets every unchecked (`empty`) entry before the setting is saved,
so the stored `referencable_bundles` is a compact array of `entity_type:bundle` strings. An empty
array means **no restriction** (all content bundles selectable).

## Widget — `bundle_reference_widget`

`src/Plugin/Field/FieldWidget/BundleReferenceWidget.php` (id **`bundle_reference_widget`**),
`WidgetBase` + `ContainerFactoryPluginInterface`, injecting `entity_type.bundle.info` and
`entity_type.manager`.

`formElement()` builds two dependent selects:

1. **Entity type** select (`#type => select`). Options start with `-- Select entity type --`, then
   every `ContentEntityTypeInterface` definition from `entityTypeManager->getDefinitions()`. If
   `referencable_bundles` is set, only entity types present in the whitelist are offered.
   It has an `#ajax` callback keyed to a per-delta wrapper id built with
   `Html::cleanCssIdentifier($fieldName . '-bundle-' . $delta)`.
2. **Bundle** select — shown once an entity type is chosen (from the AJAX trigger value, or the
   submitted/stored value resolved via `$form_state->getValue($parents)`). Options come from
   `bundleInfo->getBundleInfo($current_entity_type)`, filtered to the whitelist when set. The
   element is wrapped in `<div id="{html_id}">…</div>` so AJAX can replace it.

`ajaxCallback()` (static) returns the rebuilt `bundle` sub-element by walking the trigger's
`#array_parents` (drop last, append `bundle`) with `NestedArray::getValue()`.

Multi-value fields: each delta gets its own wrapper id, so cascading selects work per row.

## Formatter — `bundle_reference_formatter`

`src/Plugin/Field/FieldFormatter/BundleReferenceFormatter.php` (id
**`bundle_reference_formatter`**), `FormatterBase` + `ContainerFactoryPluginInterface` (injects
`entity_type.manager`, though it is not used in output). `viewElements()` returns a single
`#theme => item_list` render array with `#empty => "No referenced bundles."`; for each non-empty
item it appends `"{$item->entity_type}: {$item->bundle}"` to `#items`. Output is machine names
rendered as plain text via the item-list theme (escaped) — it does **not** show bundle labels or
load any entity.

## Config example (field storage + instance)

```yaml
# field.storage.node.field_target_bundle
type: bundle_reference
settings: {}
cardinality: 1

# field.field.node.article.field_target_bundle
field_type: bundle_reference
settings:
  referencable_bundles:
    - 'node:article'
    - 'node:page'
```

## Operating notes

- The value is only ever two machine names; consumer code reads `$entity->field_x->entity_type`
  and `$entity->field_x->bundle`. There is no `->entity` — nothing to load, so no referential
  integrity: if a bundle is later deleted, stored values keep the (now dangling) machine name.
- Changing `referencable_bundles` does not rewrite existing values; it only constrains new edits.
- The formatter shows raw machine names. For a human label, render the value in a custom
  formatter/preprocess by mapping through `entity_type.bundle.info`.
- `getBundleOptions()` and the widget list only content entity types, so config entity "bundles"
  and entity types without bundles are not selectable.
