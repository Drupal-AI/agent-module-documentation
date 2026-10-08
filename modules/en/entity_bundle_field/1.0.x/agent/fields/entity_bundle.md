<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity bundle reference" field type

## Install & enable

```bash
composer require drupal/entity_bundle_field
drush en entity_bundle_field -y
```

No dependencies outside Drupal core. No submodules, permissions, Drush commands, config objects,
config schema, routes, services, or hooks — the whole module is the three Field API plugins in
`src/Plugin/Field/`.

## Add the field

*Structure → (entity type) → Manage fields → Add field* → choose **Entity bundle reference**
(field type id `entity_bundle`, category *reference*). It can be attached to any fieldable entity
(node, term, user, paragraph, …). Cardinality is **fixed at 1** (declared in the plugin
annotation of `EntityBundle`).

### Field settings — pick the target entity type

`EntityBundle::fieldSettingsForm()` (`src/Plugin/Field/FieldType/EntityBundle.php`) adds one
`select`, **"Select entity bundle type"**, stored in the field setting **`entity_type`**
(default `''`, from `defaultFieldSettings()`). Its options are every entity type whose
`$entity_type->getBundleEntityType()` is non-empty — i.e. every **bundleable** entity type
(Node, Taxonomy term, Media, Block content, Comment, Contact form, etc.), keyed by entity type id
and labelled with the entity type label. This setting decides which entity type's bundles the
widget will offer and the formatter will resolve.

## Stored value & schema

`EntityBundle::schema()` defines a single column **`bundles`** — `varchar`, length **255**,
no indexes. `propertyDefinitions()` exposes one string property **`bundles`** ("Select option",
not required). The stored value is the **bundle machine name** (e.g. `article`, `tags`), not an
entity id. `isEmpty()` returns TRUE when `bundles` is `NULL` or `''`.

Note: the field type has **no config schema** shipped (there is no `config/schema/`), so strict
config-schema tooling may flag the `entity_type` field-storage/settings value; it still saves and
works.

## Widget — the bundle select

`EntityBundleWidget` (`src/Plugin/Field/FieldWidget/EntityBundleWidget.php`, id
`entity_bundle_widget`; the field type's `default_widget`). `formElement()`:

- reads the field's `entity_type` setting; if empty, renders nothing;
- loads the target entity type definition and its bundle entities via
  `entity_type.manager`'s storage of `$definition->getBundleEntityType()` (`loadMultiple()`);
- builds a `select` (`#empty_option` = *"- None -"*) whose options map each bundle **id → label**,
  defaulting to the current item value.

`massageFormValues()` flattens the submitted `bundles` sub-value into the item's stored value.
There is also a helper `getSelections()` returning an array of the item values.

## Formatter — render the bundle label

`EntityBundleFormatter` (`src/Plugin/Field/FieldFormatter/EntityBundleFormatter.php`, id
`entity_bundle_formatter`, label *"Entity Bundle Formatter"*; the field type's
`default_formatter`). It injects `entity_type.manager` and `entity_type.bundle.info` via
`create()`. `viewElements()`:

- reads the field's `entity_type` setting; if empty or the entity type is unknown, renders nothing;
- fetches `entity_type.bundle.info`'s bundle info for that entity type;
- per item, looks up `$bundleInfo[$item->bundles]['label']` and renders it, falling back to the
  translated string **"Undefined"** when the stored bundle id is not found;
- output goes through an `inline_template` `{{ value|nl2br }}` render element (Twig autoescapes the
  label).

## Operate it

1. Add the **Entity bundle reference** field and set **Select entity bundle type** to the entity
   type whose bundles you want to expose.
2. On *Manage form display*, the **Entity Bundle Widget** shows editors a select of that entity
   type's bundles; the chosen bundle machine name is saved.
3. On *Manage display*, the **Entity Bundle Formatter** shows the bundle's human-readable label.
4. For a decoupled front end, the raw stored `bundles` machine name is available through
   JSON:API/REST like any other field property.

## Caveats

- Cardinality is hard-coded to 1 — one bundle per field instance.
- The value is a bare machine-name string, not an entity reference, so there is no referential
  integrity: if the target bundle is later deleted, stored values keep the old machine name and the
  formatter renders *"Undefined"*.
- The Spanish-language docblock on `fieldSettingsForm()` ("Define el formulario del campo") is
  cosmetic only.
