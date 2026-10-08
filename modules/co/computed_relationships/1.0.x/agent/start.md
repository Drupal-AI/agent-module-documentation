<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computed relationships (computed_relationships) — agent index

info.yml name **"Computed relationships"**; description *"Provides the power to reference entities
dynamically."* Version **1.0.0-beta5** (beta; `security_advisory_coverage: not-covered`). Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Depends only on core **`field`**.

- **The config entity, the computed field, JSON:API/jsonapi_extras behavior, routes & permission** →
  [fields/computed-relationship.md](fields/computed-relationship.md)

## What it actually is

Not rule-based derivation. An admin defines **`computed_relationship`** config records; each one
pins a **fixed, hand-picked list of target entities** (chosen by UUID) to a **computed
`entity_reference` base field** that the module attaches to a chosen **source** entity type. When a
source entity is loaded, the field resolves to that same fixed target set at runtime — so you get a
reference field whose values are declared once centrally instead of stored/maintained per entity.
JSON:API exposes it like any reference; with `jsonapi_extras` present the field is registered into
existing resource configs automatically.

## Provides (all from source)

- **Content entity type `computed_relationship`** (`src/Entity/ComputedRelationship.php`),
  `base_table = computed_relationship`, `admin_permission = "administer computed relationship"`,
  `AdminHtmlRouteProvider`. Base fields: `label`, `status`, `uid` (owner), `created`, `changed`,
  `computed_field_name`, `source_entity_bundle` (list_string `entitytype__bundle`),
  `target_entity_bundle` (same shape), `target_entities` (unlimited list_string of target UUIDs).
- **Permission** `administer computed relationship` (`*.permissions.yml`, `restrict access: true`) —
  gates every route below.
- **Entity routes** (from links, all admin-gated): collection `/admin/content/computed-relationship`,
  add `/computed-relationship/add`, canonical `/computed-relationship/{id}`, edit `…/edit`,
  delete `…/delete`. Menu/action/task links in `computed_relationships.links.*.yml`.
- **Service** `computed_relationships.helper` → `Helper\ComputedRelationshipsHelper`
  (`buildComputedFields()`, `autoexport_jsonapi_extras_configuration()`, `tableExists()`).
- **Form** `Form\ComputedRelationshipForm` (AJAX target-entity picker), **list builder**
  `ComputedRelationshipListBuilder`, **computed field class**
  `Plugin\Field\ComputedRelationshipsField` (extends `EntityReferenceFieldItemList` +
  `ComputedItemListTrait`).
- **Hook** `computed_relationships_entity_base_field_info_alter()` — adds the computed base field(s)
  to content entity types that are the source of a relationship. No install/schema file, no config
  objects of its own, no Drush, no JS, no templates.

## Mechanism (from source)

1. `hook_entity_base_field_info_alter($fields, $entity_type)`: returns early unless the DB table
   exists and the type is a `ContentEntityInterface`; queries `computed_relationship` where
   `source_entity_bundle` **STARTS_WITH** the entity type id, then
   `ComputedRelationshipsHelper::buildComputedFields()` builds the fields.
2. `buildComputedFields()`: for each record creates a computed `entity_reference`
   `BaseFieldDefinition` named by `computed_field_name`, `target_type` = target entity type,
   `CARDINALITY_UNLIMITED`, `setClass(ComputedRelationshipsField)`; stores `target_entities`,
   `source_type`, and the config entity as settings. Records sharing a `computed_field_name` **merge**
   their target lists. If `jsonapi_extras` is enabled, calls `autoexport_jsonapi_extras_configuration()`.
3. `ComputedRelationshipsField::computeValue()`: loads each target by UUID
   (`loadByProperties(['uuid' => …])`), de-duplicates by UUID, appends each as a reference item.
   (The `source_type` guard compares the config value to a setting derived from it, so it does not
   filter by the viewed entity's own bundle — the field surfaces on every bundle of the source type
   outside jsonapi_extras.)
4. On save (`ComputedRelationshipForm::save()`): empty `label` defaults to `"source > target"`;
   empty `computed_field_name` defaults to `source__target`. Entity validation is disabled; a manual
   required-field check runs in `validateForm()`.

## Notes / caveats

- **Beta, not security-covered.** Field is a **base field on the whole source entity type**, not a
  per-bundle field, despite the project blurb implying per-bundle placement (jsonapi_extras is the
  only place bundle scoping is applied).
- Entity access on referenced targets is delegated to the consumer (core reference formatters and
  JSON:API both access-filter) — the module does not add its own view check.
- `jsonapi_extras` autoexport only touches **already-existing**
  `jsonapi_extras.jsonapi_resource_config.<type>--<bundle>` config; it never creates one.
- `ComputedRelationshipsField.php` carries two dangling `use` imports (`paragraphs`,
  `ptur_term_municipality`) left over from its origin project; unused, harmless at runtime.
