# Workbench Access scheme on a hierarchy field

## Prerequisites

- `workbench_access` and `entity_hierarchy` enabled.
- The target entity type/bundle already has an `entity_reference_hierarchy` field
  (e.g. `field_parent` on nodes).

## Create the access scheme

Workbench Access owns the config. In the UI at
`/admin/config/workflow/workbench_access`, add an **Access scheme** and choose the
**"Entity hierarchy"** access-control type. The plugin id is `entity_hierarchy` and it is
**derived per hierarchy field** (`WorkbenchAccessControlDeriver`), so you pick the specific
entity type + hierarchy field the scheme should follow. Then select the covered **bundles**.

Scheme settings are stored under
`workbench_access.scheme_settings.entity_hierarchy:<derivative>` with:

- `boolean_fields` — the hierarchy field(s) used (mapped from the scheme's `parents`).
- `bundles` — bundles the scheme applies to.

(`hook_workbench_access_scheme_update_alter()` fills these in from the scheme form on save.)

## How sections work

- A **section** = a node in the hierarchy tree. Assigning a user/role to a section (standard
  Workbench Access user/role-section assignment) grants access to that node **and all its
  descendants**, resolved from the parent module's nested-set storage
  (`entity_hierarchy.nested_set_storage_factory`).
- The plugin caches the computed tree in a dedicated cache bin **`entity_hierarchy_wba`**
  (cache id `entity_hierarchy_tree`).

## Validation

`hook_entity_bundle_field_info_alter()` adds a **`ValidHierarchySection`** constraint to the
hierarchy field on the scheme's bundles, so an editor cannot set a parent that would place
content into a section they are not allowed to use.

## Notes

- There is no settings form in this submodule itself — everything is configured through
  Workbench Access's access-scheme admin and its user/role section assignment.
- You can create multiple schemes over different hierarchy fields or entity types.
