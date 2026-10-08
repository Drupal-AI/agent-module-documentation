<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity References Finder (entity_reference_finder) — agent index

Admin report that lists which `entity_reference` / `entity_reference_revisions` **field
configurations** target a chosen content entity type + bundle. Package `Administration`. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1. No composer.json, no
declared module dependencies (uses core `field` at runtime), no config objects/schema, no services,
no plugins, no Drush.

- **The report form, how it discovers fields, the route, permission and menu link** →
  [report/finder.md](report/finder.md)

## What it actually is

- One form: `EntityReferenceFinderForm` (form id `entity_reference_finder`), in
  `src/Form/EntityReferenceFinderForm.php`, extending core `FormBase`. It is a read-only report —
  `submitForm()` is empty.
- Route `entity_reference_finder.page` → path `/admin/reports/entity_reference_finder`
  (`_form` = the form, `_title` = "Entity References Finder"), gated by permission
  `access administration entityreferencefinder`.
- Menu link (`entity_reference_finder.links.menu.yml`) under `system.admin_reports`
  (Administration → Reports).
- Permission (`entity_reference_finder.permissions.yml`): `access administration entityreferencefinder`
  ("View entity reference finder page"). No `restrict access` flag.

## Mechanism (from source)

- Two AJAX selects: **Entity** (content entity types only, from
  `EntityTypeManagerInterface::getDefinitions()` filtered to `ContentEntityType`) and **Bundle**
  (from `EntityTypeBundleInfoInterface::getBundleInfo()`), then a results **table**.
- `getFields($entityBase, $bundleBase)` iterates field types `entity_reference` and
  `entity_reference_revisions` via `EntityFieldManagerInterface::getFieldMapByFieldType()`, loads
  each `FieldConfig::loadByName()`, and keeps a field only when its `target_type` setting equals the
  selected entity type **and** `handler_settings['target_bundles']` contains the selected bundle.
- This is a **field-configuration** lookup (which fields are set up to reference the bundle), not a
  query over stored content. Fields with no `target_bundles` restriction are not matched.
- Output rows (field name, owning entity type id, owning bundle label) are rendered as table cells.
