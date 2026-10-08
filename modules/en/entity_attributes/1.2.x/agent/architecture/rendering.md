<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins, storage, and how attributes reach the markup

## Plugin type

Plugin manager `EntityAttributesManager` (`src/EntityAttributesManager.php`) discovers plugins in
`Plugin/EntityAttributes/`, keyed by the `EntityAttributes` PHP attribute
(`src/Attribute/EntityAttributes.php`; annotation fallback `src/Annotation/EntityAttributes.php`),
implementing `EntityAttributesInterface`. Alter hook `entity_attributes_info`; cache
`entity_attributes_plugins`. Attribute properties: `id`, `label`, `entity_types` (array, may be null
for dynamic types), `description`, `config_tab`, `config_tab_label`, `config_section`.

Key manager methods: `getPluginForEntityType()`, `pluginSupportsEntityType()`,
`isPluginEnabled($entity_type, $bundle)` (delegates to the plugin's `hasAttributesField()`).

## Base classes

- `EntityAttributesBase` — `getEntityTypes()`, `getBundles()`, `getEntityTypeLabel()`,
  `getFieldName()` (always `entity_attributes`), and `getSupportedAttributeSets()` (default
  `['attributes']`).
- `ContentEntityAttributesBase` — real fields. `addAttributesField()` creates a shared
  `FieldStorageConfig` (`string_long`, cardinality 1, `locked`, `persist_with_no_fields`) plus a
  per-bundle `FieldConfig`, then configures the form display to use the `entity_attributes_yaml`
  widget and **removes** the field from the view display (`configureViewDisplay()`).
  `removeAttributesField()` deletes the FieldConfig, and `cleanupFieldStorage()` drops the storage
  when no bundle uses it. `updateFieldStorageLockStatus()` locks/unlocks storage based on config.
- `ConfigEntityAttributesBase` — no fields; `hasAttributesField()` reads
  `entity_attributes.settings:enabled_bundles.{entity_type}`; attributes live in the entity's
  `third_party_settings`. `removeAttributesField()` strips `attributes_data` from all entities.

## Bundled plugins

Content: `NodeAttributes` (`attributes`, `title_attributes`, `content_attributes`,
`author_attributes`), `TaxonomyTermAttributes` (`attributes`), `MenuLinkContentAttributes`
(`attributes`, `link_attributes`). Config: `BlockAttributes` and `MenuAttributes` (`attributes`,
`title_attributes`, `content_attributes`), `StaticMenuLinkAttributes` (`attributes`,
`link_attributes`). Submodules add `paragraph` and `eck_entity` (dynamic entity types).

`StaticMenuLinkAttributes` stores per-plugin data in the config object
`entity_attributes.static_menu_link_overrides`, keying by `encodeId()` (`.` → `__`, `__` → `___`)
via `getAttributes()` / `setAttributes()`.

## Field form: widget + field service

- `AttributesWidget` (`entity_attributes_yaml`, `src/Plugin/Field/FieldWidget/AttributesWidget.php`)
  renders the value as a `details`-wrapped `textarea` (or a `codemirror` element when
  `use_codemirror` is on and `codemirror_editor` exists). Setting `collapsed` controls the initial
  open state. `massageFormValues()` stores the YAML string unchanged.
- `EntityAttributesField` (`src/EntityAttributesField.php`) is the glue for entity forms:
  - `alterFieldWidgetSingleElementForm()` (from `hook_field_widget_single_element_form_alter`)
    enhances the content-entity `entity_attributes` field, hides it (`#access = FALSE`) for users
    without the per-bundle permission, and adds a "Supported attribute sets" description +
    default YAML skeleton (`generateDefaultYamlValue()`).
  - `alterMenuLinkContentForm()`, `alterStaticMenuLinkForm()`, `alterBlockForm()`, `alterMenuForm()`
    add or restructure the attributes field on the respective forms (all guarded by the per-bundle
    permission check) and register the YAML→array submit handlers `submitConfigEntityYaml()` /
    `submitStaticMenuLinkYaml()`.
- `FieldHooks` (`src/Hook/FieldHooks.php`) wires the above via `#[Hook]` attributes, and via
  `hook_entity_bundle_field_info_alter` adds the `ValidYaml` constraint to the field's `value`
  property. `hook_entity_type_build` marks `menu_link_content` fieldable when its plugin is enabled.

## YAML validation

`ValidYamlConstraint` + `ValidYamlConstraintValidator` (`src/Plugin/Validation/Constraint/`):
`Yaml::decode()` the value; add a violation if it throws, or if the parsed result is neither an array
nor null. Applied to content-entity fields as a property constraint and to config-entity form
elements through `EntityAttributesField::validateConfigEntityYaml()`.

## From storage to template (the render path)

`EntityAttributesProcessor` (`src/EntityAttributesProcessor.php`) is invoked from preprocess hooks
(`src/Hook/PreprocessHooks.php`, `#[Hook('preprocess_node' | 'preprocess_taxonomy_term' |
'preprocess_menu' | 'preprocess_block')]`; submodules add `preprocess_paragraph` /
`preprocess_eck_entity`):

- `processContentEntityAttributes()` — checks the plugin is enabled + field non-empty, then
  `Yaml::decode()`s the stored field string and calls `applyAttributesToVariables()`.
- `processConfigEntityAttributes()` — reads `getThirdPartySetting('entity_attributes',
  'attributes_data')` and applies it (used for blocks and menus).
- `processMenuItems()` — recurses `variables['items']`, dispatching each item to
  `processMenuLinkContentAttributes()` (loads the `menu_link_content` entity by id) or
  `processStaticMenuLinkAttributes()` (reads the static override config).
- `applyAttributesToVariables()` — for each supported attribute set present in the data: if the
  existing template variable is already a core `Attribute` object it builds
  `new Attribute($data)` and `->merge()`s into it; otherwise it sets the variable to
  `NestedArray::mergeDeep($existing_array, $data)`. The theme layer then turns the standard
  `attributes` / `title_attributes` / `content_attributes` variables into `Attribute` objects at
  render time. (The code keeps plain arrays for the standard sets on purpose so theme
  post-processing with array helpers — e.g. the D11.4 block stable9 back-compat layer — does not
  discard them; see the code comment referencing drupal.org/node/3525287.)

Themers print the results with `<article{{ attributes }}>`, `<h1{{ title_attributes }}>`,
`<div{{ content_attributes }}>`, and for menus `{{ link(item.title, item.url, item.link_attributes) }}`.
The **formatter** `AttributesFormatter` (`entity_attributes_hidden`) intentionally returns `[]` — the
field is never shown as display output; only preprocess applies it.

## Extending to a new entity type

Create an `EntityAttributes` plugin (extend `ContentEntityAttributesBase` or
`ConfigEntityAttributesBase`, or implement `EntityAttributesInterface`), override
`getSupportedAttributeSets()` as needed, add a form alter for config/custom entities, and implement a
preprocess hook that calls the `entity_attributes.processor` service — exactly as the two submodules
do.
