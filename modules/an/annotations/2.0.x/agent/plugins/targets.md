<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations — target plugin system

Target plugins describe how one entity type is exposed to the annotation scope system: which bundles exist and which fields are annotatable.

## Discovery

- Manager: `plugin.manager.annotations_target` → `TargetPluginManager` (`src/TargetPluginManager.php`), subdir `Plugin/AnnotationsTarget`, interface `TargetInterface`, attribute `#[AnnotationsTarget]`, alter hook `annotations_target_info`, cache key `annotations_target_plugins`.
- Attribute `#[AnnotationsTarget(id, label?, entity_type_id?, deriver?)]` (`src/Attribute/AnnotationsTarget.php`). By convention `id` == the entity type id; `entity_type_id` defaults to the plugin id (`processDefinition()`).
- Any enabled module can add a plugin by placing a class in `src/Plugin/AnnotationsTarget/` — no service registration.
- `getPlugins()` returns one plugin instance per entity type. A dedicated plugin **shadows** the `GenericTarget` derivative for the same entity type (specific wins over generic).

## Base class — `Plugin/AnnotationsTarget/TargetBase.php`

Implements `discover(array $scopes)`, `getBundles()`, `isAvailable()`, `getEntityTypeId()`, `getLabel()`, `hasFields()`. `discover()` walks the bundles named in the passed `annotation_target` scopes and returns per-bundle field metadata (label/type/required/cardinality/description) for each field the target marks in-scope.

Field eligibility is `TargetBase::isEditorialField($name, $definition)`:
- configurable fields (`FieldConfigInterface`, not `BaseFieldOverride`) → always in scope;
- base fields provided by `annotations`/`annotations_*` → excluded (would be circular);
- a curated `BASE_FIELD_OVERRIDES` map (title/body/name/description = TRUE; id/uuid/uid/langcode/status/created/changed/path/sticky/promote/moderation_state = FALSE);
- `revision_*` prefix → excluded;
- else falls back to `isDisplayConfigurable('form'|'view')`.
`isNotableBaseField()` returns the higher-signal `BASE_FIELD_OVERRIDES == TRUE` subset.

## Generic catch-all — `GenericTarget` + `GenericTargetDeriver`

`#[AnnotationsTarget(id: 'generic', deriver: GenericTargetDeriver::class)]`. The deriver (`src/Plugin/Derivative/GenericTargetDeriver.php`) derives one instance per **fieldable** entity type, skipping types provided by `annotations*`. Ensures ECK / hand-rolled fieldable entities appear in the scope UI without a dedicated plugin; the manager drops the duplicate where a dedicated plugin exists.

## Dedicated plugins (`src/Plugin/AnnotationsTarget/`)

`NodeTarget` (label "Content types"; excludes `annotations_*` node bundles), `TaxonomyTarget`, `UserTarget`, `RoleTarget`, `MediaTarget`, `MenuTarget`, `ViewTarget`, `ParagraphTarget`, `WorkflowTarget`. Non-fieldable types (roles, views, menus, workflows) override `getBundles()`/`discover()` and are NOT derived generically. Submodule `annotations_webform` adds `WebformTarget` (`hasFields()` FALSE) and `WebformSubmissionTarget` (enumerates webform input elements as fields).

## Adding a plugin

Create `src/Plugin/AnnotationsTarget/MyTypeTarget.php` extending `TargetBase` with `#[AnnotationsTarget(id: 'my_entity_type', label: new TranslatableMarkup('My things'))]`. Override `getBundles()`/`discover()` only if the entity type is non-fieldable or needs custom scope semantics.
