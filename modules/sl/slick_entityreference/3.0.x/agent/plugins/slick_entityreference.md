<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter plugins

The module defines **two** `@FieldFormatter` plugins (in
`src/Plugin/Field/FieldFormatter/`). It defines no plugin *types* of its own — it plugs into
core's Field Formatter plugin type. Both extend Slick's `SlickEntityFormatterBase`
(Blazy-based), so they inherit its settings (`optionset`, `view_mode`, thumbnail/nav
optionset, skin, image style, cache).

| Formatter id | Label | Field types | Class |
|---|---|---|---|
| `slick_entityreference_vanilla` | Slick Entity Reference Vanilla | `entity_reference`, `entity_reference_revisions` | `SlickEntityReferenceVanillaFormatter` |
| `slick_dynamicentityreference_vanilla` | Slick Dynamic Entity Reference Vanilla | `dynamic_entity_reference` | `SlickDynamicEntityReferenceVanillaFormatter` |

Use `slick_entityreference_vanilla` for normal entity-reference and
entity-reference-revisions (Paragraphs) fields — this is the one you want in almost every
case. The dynamic variant exists only for fields provided by the contrib
`dynamic_entity_reference` module (its class `use`s that module's
`DynamicEntityReferenceFormatterTrait`).

## Applicability rule

Both override `isApplicable()`:

```php
public static function isApplicable(FieldDefinitionInterface $field_definition) {
  $storage = $field_definition->getFieldStorageDefinition();
  return $storage->isMultiple();
}
```

So a formatter appears in the Manage-display "Format" dropdown **only for multi-value
fields** (cardinality > 1 or unlimited). A single-value reference field will not offer it —
a carousel needs multiple items.

## What "vanilla" means / prepareView

"Vanilla" = each referenced entity is rendered as-is through its view mode (no image/overlay
slide compositing like `slick_paragraphs_media`). Both override `prepareView()` to set
`$item->_loaded = TRUE` for each item whose `->entity` loads, so entity-reference-revisions
(which lack a multiload/static cache) render without triggering "not loaded" errors.

## No new plugin types

The module provides no plugin manager, annotation/attribute, or `Plugin/` type of its own —
`provides_plugin_types` is `[]`. To customise carousel behaviour you configure a **Slick
optionset** (a `slick` config entity from the Slick module), not a plugin here.
