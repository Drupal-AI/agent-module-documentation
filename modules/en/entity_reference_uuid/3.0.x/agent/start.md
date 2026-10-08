<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference UUID (entity_reference_uuid) — agent index

Provides the **`entity_reference_uuid`** field type: an entity reference stored by the target's
**UUID** instead of its numeric entity ID, so references stay valid across migrations, content
deployments and multi-environment moves. Version **3.0.1**. Core **`^11.1` — Drupal 11.1+ only**.
No dependencies beyond core; license GPL-2.0-or-later; provides config schema only (no permissions,
no Drush, no configuration form).

## Mechanism (real names)

- **Field type** — `EntityReferenceUuidItem` (`src/Plugin/Field/FieldType/EntityReferenceUuidItem.php`)
  extends core `EntityReferenceItem`. Keeps `target_type` storage setting and `handler` /
  `handler_settings` field settings; **main property is `target_uuid`** — a `varchar_ascii(128)`,
  indexed. **Only the UUID column is stored** (no `target_id` in the table). `entity` stays a
  computed property. `onChange()` / `referencedEntities()` resolve the UUID via
  `loadByProperties(['uuid' => ...])`; `preSave()` + `hasNewEntity()` handle autocreate (save the
  new entity, then capture its UUID).
- **Item list** — `EntityReferenceUuidFieldItemList` adds core's **`ValidReference` constraint**
  (target exists, correct type/bundle, reference access) on top of the `EntityType` constraint;
  overrides `referencedEntities()`, `processDefaultValue()` (UUID → id, `accessCheck(TRUE)`) and
  `defaultValuesFormSubmit()` (id → UUID, for deployable defaults).
- **Widgets** — default `entity_reference_autocomplete`; `hook_field_widget_info_alter`
  (`src/Hook/EntityReferenceUuidHooks.php`) also enables `entity_reference_autocomplete_tags`,
  `options_select`, `options_buttons`, `inline_entity_form_simple`/`_complex`,
  `select2_entity_reference`, `chosen_select`. All are core/contrib reference widgets using the
  selection handler — access-checked.
- **Formatters** — default is core `entity_reference_label`; module adds
  `entity_reference_uuid_entity_view` ("Rendered entity", `EntityReferenceUuidEntityFormatter`)
  which renders through core `getEntitiesToView()` + the entity view builder (referenced-entity
  `view` access **is** checked). `EntityReferenceUuidFormatterBase::prepareView()` only sets the
  `_loaded` flag.
- **Entity query** — `EntityReferenceUuidServiceProvider` swaps the SQL `Tables` class
  (`src/Query/Tables.php`) so a query on a `entity_reference_uuid` field left-joins the target base
  table on `uuid` instead of the id column.
- **Views** — `EntityReferenceUuidViewsHooks` registers forward + reverse relationships
  (handlers `entity_standard_uuid`, `entity_reverse_uuid`), a UUID taxonomy filter
  (`entity_reference_uuid_taxonomy_index_uuid`, `accessCheck(TRUE)` + `taxonomy_term_access` tag),
  and `EntityReferenceUuidEntityViewsTrait` for base-field relationships.

## Trade-offs / gotchas

1. **UUID lookups cost more than ID lookups** — a 36-char string compare, not an indexed integer.
   Per-row resolution in large listings is measurably slower. That is the price of portability.
2. **The target may not exist yet** — intended during a deployment; rendering tolerates an
   unresolvable reference rather than erroring.
3. **Core already uses UUIDs for this** (`default_content`, config entity dependencies). This just
   makes the pattern available to ordinary content fields.
4. **Views data note:** the UUID is not physically in the data table; the module fakes its presence
   via `hook_views_data_alter()`, so relationships join base tables on `uuid`.

## Files here

- `data.json` — metadata.
- `usage.md` — short / detailed / use-case bullets.
- `agent/fields/entity-reference-uuid.md` — how to add and use the field type.
