<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Segment type + segment entity

Two entity types back the engine. Cite: `src/Entity/SegmentType.php`, `src/Entity/Segment.php`, `config/schema/entity_segment.schema.yml`.

## `segment_type` — config entity (bundle)

`SegmentType` (`#[ConfigEntityType(id: 'segment_type')]`) extends `ConfigEntityBundleBase`; it is `bundle_of: segment`. `config_prefix: segment_type`, `admin_permission: administer segment types`.

- `config_export`: `id`, `label`, `target_entity_type_id`. Schema `entity_segment.segment_type.*` (a `config_entity` with those three keys).
- `getTargetEntityTypeId()` returns the target content entity type this bundle's segments select. Must be a queryable content entity type (base-table storage).
- Links/collection under `/admin/structure/segment-type` (`AdminHtmlRouteProvider`, forms `SegmentTypeForm` + core `EntityDeleteForm`, list builder `SegmentTypeListBuilder`).
- Changing `target_entity_type_id` after segments exist re-targets them (stored conditions were written against the old target's fields); treat as fixed once segments exist — not locked in this alpha.

Ship one as install config, e.g.:
```yaml
langcode: en
status: true
dependencies:
  enforced:
    module: [your_module]
id: event
label: 'Event'
target_entity_type_id: node
```

## `segment` — content entity

`Segment` (`#[ContentEntityType(id: 'segment')]`, `base_table: segment`, `revision_table: segment_revision`), `bundle_entity_type: segment_type`. Uses `EntityChangedTrait` + `EntityOwnerTrait`. `admin_permission: 'administer segment types'`, but per-entity access is decided by `SegmentAccessControlHandler` (see api/resolver-and-access.md).

Handlers: `access` = `SegmentAccessControlHandler`; `query_access` = `SegmentQueryAccessHandler`; `list_builder` = `SegmentListBuilder`; forms `SegmentForm` (add/edit/default) + `SegmentDeleteForm`; `route_provider.html` = `SegmentHtmlRouteProvider`; `views_data` = core `EntityViewsData`. `field_ui_base_route: entity.segment_type.edit_form` so each type can carry its own fields (no hard dep on field_ui).

Base fields (`baseFieldDefinitions()`):
- `bundle` — entity_reference to `segment_type` (read-only, required); names the target type.
- `label` — string, required, revisionable.
- `uid` — owner (from `EntityOwnerTrait`), revisionable.
- `scope` — `list_string`, values `personal` (default) / `global`; required, revisionable. Drives the access model.
- `conditions` — `map`, revisionable; the condition tree. Empty tree is a well-formed root group `{type: group, conjunction: AND, children: []}`, never NULL. `getConditions()` / `setConditions()` accessors; view display component `entity_segment_condition_tree` (read-only formatter). No form widget here — the tree builder is supplied by `SegmentForm`.
- `revision_created`, `revision_user`, `created`, `changed`.

`preSave()` forces a new revision on every save, stamping `revision_created` + `revision_user`. Routes/links: collection `/admin/content/segments`, add-page `/add`, add-form `/add/{segment_type}`, canonical/edit/delete under `/admin/content/segments/{segment}`.

Validation: `hook_entity_type_alter` (`Hook/EntityTypeHooks`) adds an **entity-level** `ValidConditionTree` constraint (`Plugin/Validation/Constraint/ValidConditionTreeConstraint[Validator]`), so the whole tree is walked and each plugin's `validateConfiguration()` runs at save even when the form is bypassed.
