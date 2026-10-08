<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Fields (component_fields) — agent index

info.yml name **"Component Fields"**, description *"Compile a field value from component fields."*
Computes the value of one **"final"** field from **two "component" fields of the same field type**
on the same entity, at entity save time, using a pluggable compiler. It does **not** create new
field types or render anything itself — it wires together existing fields of a bundle and overwrites
the final field on `hook_entity_presave`. Package `Custom`. Core `^10 || ^11`. License
GPL-2.0-or-later. Installed **1.0.0-alpha1** (version dir `1.0.x`); early alpha, **not covered by
the Drupal security advisory policy**. `configure: component_fields.bundles`.

The use case (README): let different actors own separate fields — e.g. an import writes
`field_imported`, editors correct `field_override` — while a single `field_final` presents the
resolved value (e.g. "use the override if set, else the import"). The module provides **no**
visibility or access control of its own; final fields are meant to be non-writable because they are
recomputed on every save.

## Dependencies

None declared in `.info.yml` beyond Drupal core. The override feature relies on the bundle having a
spare `string_long` core field (used as JSON storage for per-entity overrides).

## Core mechanism (from source)

- `component_fields_entity_presave(EntityInterface $entity)` (`component_fields.module`) — on every
  content entity save, calls `component_fields.compile_service`→`compileFields($entity)`. (The file's
  `@file` docblock is a wrong copy-paste mentioning "taxonomy_fast_import"; the code is unrelated.)
- `CompileService::compileFields()` (`src/CompileService.php`) — the heart:
  1. Loads the bundle's optional override `string_long` field, `json_decode`s it to a
     `{final_field_id: compiler_id}` map.
  2. Reads the configured triads for this entity type/bundle from config
     `component_fields.settings` key `fields_config`.
  3. For each triad: gets `component_1` and `component_2` field values (`->getValue()`), picks the
     compiler (per-entity override if present, else the triad's `default_compiler`),
     `createInstance($compiler_id)`, calls `compile(c1, c2, finalFieldDefinition, entity)`, and
     `$entity->set(final_field_id, $result)`.
- `CompileService::getAllComposableFields()` — enumerates content entity types/bundles and returns,
  per bundle, only non-base fields whose **field type appears 3+ times** in the bundle (you need ≥3
  same-type fields: 1 final + 2 components, all not-yet-used). Bundles without such a group are
  dropped. `getAllComposableFieldsGroupped()` groups them by field type; `getStringLongFields()`
  lists non-base `string_long` fields (override-storage candidates).

## Compiler plugin type (from source)

Annotation-based plugin type `@ComponentFieldsCompiler` (`src/Annotation/ComponentFieldsCompiler.php`),
manager `ComponentFieldsCompilerPluginManager` (service `plugin.manager.component_fields_compiler`,
dir `Plugin/ComponentFieldsCompiler`, alter hook `component_fields_info`, interface
`ComponentFieldsCompilerInterface::compile()`). Manager `getDefinitions(bool $exclude_multivalue)`
can filter out multivalue-only compilers for single-cardinality final fields. Annotation keys:
`id`, `label`, `description`, `multivalue_only` (bool).

Six shipped compilers (`src/Plugin/ComponentFieldsCompiler/`):

| id | Class | multivalue_only | Result |
|----|-------|-----------------|--------|
| `component_1` | Component1 | FALSE | value of component 1 |
| `component_2` | Component2 | FALSE | value of component 2 |
| `component_1_fallback_2` | Component1WithFallback2 | FALSE | component 1 if truthy, else component 2 |
| `component_2_fallback_1` | Component2WithFallback1 | FALSE | component 2 if truthy, else component 1 |
| `merge` | Merge | TRUE | union (deduped) of both multivalue arrays |
| `empty_value` | EmptyValue | FALSE | always NULL |

DTO `src/DTO/ComposableField.php` = readonly `{component1Id, component2Id, finalId, compiler}`.
Add a custom compiler by placing a plugin in your module's `Plugin/ComponentFieldsCompiler/`
extending `ComponentFieldsCompilerBase`.

## Admin UI (from source)

Three tabbed config forms under `/admin/config/component-fields/settings`, all
`_permission: 'administer component fields'` (`restrict access: TRUE`, the only permission,
`component_fields.permissions.yml`). Config object `component_fields.settings`
(`config/schema/component_fields.schema.yml`: `enabled_bundles`, `fields_config`, `overrides`).

- **Bundles** — `component_fields.bundles` → `BundlesForm`: checkboxes of eligible bundles
  (those with ≥3 same-type fields). Saving prunes now-invalid `fields_config`/`overrides` entries.
- **Fields** — `component_fields.fields` → `FieldsForm`: per enabled bundle, add/remove "triads"
  (AJAX). Cascading selects: final field → two component fields (restricted to the same field type
  as the final, and excluding fields already used) → default compiler (multivalue compilers hidden
  when the final field cardinality is 1). Validated so a triad is all-set or all-empty.
- **Overrides** — `component_fields.override_fields` → `OverrideFieldsForm`: choose a spare
  `string_long` field per bundle to store per-entity overrides; on save it force-sets that field's
  form-display widget to `component_fields_override_widget`.

Field widget `ComponentFieldsWidget` (`@FieldWidget id=component_fields_override_widget`, field type
`string_long`): renders one radios element per compilable final field (options = valid compilers +
"Use default"), `massageFormValues()` drops empty/default selections and JSON-encodes the rest into
the string_long value. `hook_form_alter` (`entity_form_display_edit_form`) removes this widget from
the options of any `string_long` field that is not the bundle's configured override field.

## Notes / gotchas

- Changing a triad's default compiler does **not** recompute existing entities (README TODO); resave
  is required. No Drush command, no batch recompute.
- Compilers only move values between **same-type** fields; the final field is displayed by its own
  normal core formatter (this module renders nothing). Cardinality mismatch/multivalue handling is
  the caller's responsibility (`merge` guarded to multivalue).
- Early alpha: no tests ship and several in-code `@todo`s flag planned enhancements (bulk
  recompute, change notifications, alter-hook context). Treat as pre-release.

## Related docs

- Human setup walkthrough → [`../human-docs/index.md`](../human-docs/index.md)
- Short prose summary / keywords → [`../usage.md`](../usage.md)
