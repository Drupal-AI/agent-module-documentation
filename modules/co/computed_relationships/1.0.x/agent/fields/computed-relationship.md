<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `computed_relationship` config entity and its computed field

## Install & enable

```bash
composer require drupal/computed_relationships
drush en computed_relationships -y
drush cr
```

Only dependency is core **`field`**. No sub-modules, no Drush commands, no config objects of its
own, no install/schema file. Version on disk is **1.0.0-beta5** (beta; not security-advisory
covered).

## The entity type

`Drupal\computed_relationships\Entity\ComputedRelationship` — a **content** entity type
(`@ContentEntityType id = "computed_relationship"`, `base_table = computed_relationship`), owner-aware
(`EntityOwnerTrait`) and changed-tracked. `admin_permission = "administer computed relationship"` and
`route_provider = AdminHtmlRouteProvider`, so every route is gated by that one permission
(declared `restrict access: true` in `computed_relationships.permissions.yml`).

Base fields (`baseFieldDefinitions()`):

| Field | Type | Meaning |
|---|---|---|
| `label` | string | Human label. Empty → auto-set to `"<source> > <target>"` on save. |
| `status` | boolean (default TRUE) | Enabled/Disabled flag (informational; the field is still built regardless). |
| `uid` | entity_reference→user | Author/owner; defaults to current user, or anon (0) if unset. |
| `created` / `changed` | created / changed | Timestamps. |
| `computed_field_name` | string | **Machine name of the generated computed field.** Empty → auto `"<source>__<target>"`. |
| `source_entity_bundle` | list_string (required) | `entitytype__bundle` whose entities receive the field (e.g. `node__article`). |
| `target_entity_bundle` | list_string (required) | `entitytype__bundle` the referenced entities belong to (e.g. `node__page`). |
| `target_entities` | list_string, unlimited (required) | The **specific target entities, stored by UUID**. |

`source_entity_bundle` / `target_entity_bundle` options come from
`ComputedRelationship::getEntityBundleOptions()` — all content entity types that have bundles,
grouped by type label, cached under `computed_relationship_entity_bundle_options__<field>`. Target
options are additionally filtered to bundles that actually contain at least one entity
(`hasAnyEntities()`).

## Routes & permission

All require **`administer computed relationship`**:

| Route | Path |
|---|---|
| `entity.computed_relationship.collection` | `/admin/content/computed-relationship` (menu: *Content*) |
| `entity.computed_relationship.add_form` | `/computed-relationship/add` |
| `entity.computed_relationship.canonical` | `/computed-relationship/{computed_relationship}` |
| `entity.computed_relationship.edit_form` | `/computed-relationship/{computed_relationship}/edit` |
| `entity.computed_relationship.delete_form` | `/computed-relationship/{computed_relationship}/delete` |

The list builder (`ComputedRelationshipListBuilder`) shows ID, label, status, author, created,
entity count, machine name and updated columns.

## The add/edit form

`Form\ComputedRelationshipForm` (extends `ContentEntityForm`). Choosing **Target Entity/Bundle**
triggers an AJAX rebuild (`updateTargetEntities()`) that repopulates the **Target Entities** select
with every entity of that bundle, keyed by UUID (`getTargetEntitiesOptions()`, cached per bundle).
Core entity validation is **disabled** (`setValidationRequired(FALSE)`); the form does its own
required-field check on `uid`, `created`, `source_entity_bundle`, `target_entity_bundle`,
`target_entities`. On save it back-fills empty `label` / `computed_field_name` and redirects to the
collection.

## How the computed field is generated

1. `computed_relationships_entity_base_field_info_alter()` (in `.module`) runs for each content
   entity type. It bails if `ComputedRelationshipsHelper::tableExists()` is false (module just
   installed) or the type is not a content entity, then queries `computed_relationship` records whose
   `source_entity_bundle` **STARTS_WITH** the entity type id and calls
   `ComputedRelationshipsHelper::buildComputedFields()`.
2. `buildComputedFields()` creates, per record, a computed `entity_reference`
   `BaseFieldDefinition`:
   - name = `computed_field_name`; `target_type` = the target entity type (from
     `explode('__', target_entity_bundle)`); `CARDINALITY_UNLIMITED`; `setComputed(TRUE)`;
     `setClass(ComputedRelationshipsField::class)`; display-configurable on view.
   - settings: `target_entities` (the UUID list), `source_type` (= `source_entity_bundle`),
     `original` (the config entity), plus target type/bundle.
   - Records sharing a `computed_field_name` **merge** their `target_entities` into one field.
   - **The field is a base field on the whole source entity type** — it appears on every bundle of
     that type, not only the configured source bundle (see JSON:API note for the one exception).
3. `Plugin\Field\ComputedRelationshipsField::computeValue()` (extends
   `EntityReferenceFieldItemList`, uses `ComputedItemListTrait`): resolves each target with
   `entityTypeManager->getStorage($target_type)->loadByProperties(['uuid' => $uuid])`, removes
   duplicates by UUID (`removeDuplicates()`), and appends each as a reference item. Because it is a
   standard entity-reference item list, **core reference formatters and JSON:API apply their normal
   `view`-access filtering** to the referenced entities at display time.

## JSON:API / jsonapi_extras

- With plain **JSON:API**, the computed field serializes as a relationship like any reference field.
- If **`jsonapi_extras`** is enabled, `buildComputedFields()` calls
  `autoexport_jsonapi_extras_configuration($origin, $computed_fieldname)`. For each bundle of the
  source entity type it looks up the **existing** config
  `jsonapi_extras.jsonapi_resource_config.<type>--<bundle>` and, only if that config already exists
  and does not already list the field, adds a `resourceFields` entry
  (`disabled` = TRUE for bundles other than the source bundle — this is the one place bundle scoping
  is honored). It never creates a resource config that isn't already there.

## Operating notes

- After adding/editing/deleting a relationship, run `drush cr` so the base-field cache and the
  bundle-option cache (`computed_relationship_entity_bundle_options__*`) rebuild.
- Beta release, not security-advisory covered — evaluate before production.
