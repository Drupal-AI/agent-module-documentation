<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The reference-finder report

Source: `src/Form/EntityReferenceFinderForm.php`,
`entity_reference_finder.routing.yml`, `entity_reference_finder.permissions.yml`,
`entity_reference_finder.links.menu.yml`.

## Install / enable

`drush en entity_reference_finder`. No dependencies are declared in `entity_reference_finder.info.yml`
and there is no `composer.json`; at runtime the form uses core `field` (`FieldConfig`), which core
provides. No config is installed, no schema, no services file, no update hooks.

## Route, permission, menu

- Route `entity_reference_finder.page` (routing.yml): path
  `/admin/reports/entity_reference_finder`, `defaults._form` =
  `\Drupal\entity_reference_finder\Form\EntityReferenceFinderForm`, `_title` =
  `Entity References Finder`. Requirement: `_permission: 'access administration entityreferencefinder'`.
- Permission `access administration entityreferencefinder` (permissions.yml), title "View entity
  reference finder page". This is the only permission and the only gate on the page.
- Menu link `entity_reference_finder.page` (links.menu.yml), parent `system.admin_reports`, weight 5
  — appears under Administration → Reports.

## Form (`EntityReferenceFinderForm`)

- Extends `FormBase`; `getFormId()` returns `entity_reference_finder`. Injects
  `entity_type.manager`, `entity_type.bundle.info`, `entity_field.manager` via `create()`.
- `buildForm()` sets `autocomplete=off` and builds three parts:
  1. **Entity** select — `#options` from `getEntities()`, default `node`. On change, AJAX callback
     `changeBundleSelect()` (which calls `setRebuild()`) replaces the `#bundle` wrapper.
  2. **Bundle** select (inside the `#bundle` wrapper) — `#options` from `getBundles($entity)` (a
     leading `- Select -` empty option plus each bundle). On change, AJAX callback `changeTable()`
     replaces the `#table` wrapper.
  3. **Table** (`#type => table`, wrapper `#table`) with headers Field / Entity type / Bundle and
     `#empty` = "No reference found".
- `submitForm()` is empty — the page never mutates state; results are produced entirely during
  AJAX-driven rebuilds.

## How discovery works (`getFields()`)

For each field type in `['entity_reference', 'entity_reference_revisions']`:

1. `entityFieldManager->getFieldMapByFieldType($field_type)` gives a map of entity type → field name
   → `['type' => ..., 'bundles' => [...]]`.
2. For each field/bundle, `FieldConfig::loadByName($entity, $field_bundle, $field_name)` loads the
   field config.
3. Keep the field when both hold:
   - `$def->getSetting('target_type') === $entityBase` (the selected entity type), and
   - `isset($def->getSetting('handler_settings')['target_bundles'][$bundleBase])` (the selected
     bundle is among the field's allowed target bundles).
4. Matching fields become rows `[field_name, owning entity type id, owning bundle label]`.

Consequences worth knowing:

- It reports **field configuration**, not stored content. A field that could reference the bundle is
  listed even if no entity actually uses it; conversely it does not tell you which specific entities
  hold references.
- Fields that reference the target type but leave `target_bundles` empty/unrestricted are **not**
  matched (the `isset(...[$bundleBase])` check fails).
- Only content entity types are offered (`getEntities()` filters
  `entityTypeManager->getDefinitions()` to `ContentEntityType`).

## Helpers

- `getEntities()` — content-entity-type id → label options.
- `getBundles($entity)` — `- Select -` plus bundle id → label, from
  `entityTypeBundleInfo->getBundleInfo($entity)`.
- Table cells are built as `['#markup' => $field_item]` for field name, entity type id, and bundle
  label.

## Operate it

1. Enable the module and grant `access administration entityreferencefinder` to the roles that
   should audit reference wiring.
2. Go to Administration → Reports → Entity Reference Finder
   (`/admin/reports/entity_reference_finder`).
3. Choose an entity type, then a bundle. The table refreshes via AJAX to list the matching reference
   fields, or shows "No reference found" when none target that bundle.
