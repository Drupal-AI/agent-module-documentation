<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations — configuration & admin

## Config objects (`config/install/`, schema `config/schema/annotations.schema.yml`)

- `annotations.settings` — `use_accordion_single` (bool, default TRUE): single-open accordions in suite UIs. Edited at `annotations.settings` (`AnnotationsSettingsForm`).
- `annotations.target_types` — `enabled_target_types` (sequence of entity type IDs opted in for annotation). Managed by `TargetTypesForm`.
- `annotations.target.*` — one per opted-in scope (see entity model): `id`, `label`, `entity_type`, `bundle`, `fields[]`.
- `annotations.annotation_type.*` — annotation bundles: `id`, `label`, `description`, `weight`.
All config objects are `FullyValidatable`. `config_devel: views.view.annotations`.

## Routes / admin UI (`annotations.routing.yml`, `annotations.links.*.yml`)

- `annotations.admin` — `/admin/config/annotations` (system admin menu block; `administer annotations`). Menu parent for the suite; `configure: annotations.admin` in the info file.
- `annotations.settings` — `/admin/config/annotations/settings` (`AnnotationsSettingsForm`; `administer annotations`).
- `annotations.configure` — `/admin/config/annotations/types` (`TargetTypesForm`; `administer annotation targets`) — enable/disable entity types for annotation.
- `entity.annotation_target.collection` — `/admin/config/annotations/targets` (`TargetOverviewForm`; `administer annotation targets`) — the scope accordion.
- `annotations.target.fields` — `/…/targets/{annotation_target}/fields` (`_entity_form: annotation_target.fields` → `TargetFieldsForm`, registered via `AnnotationsHooks::entityTypeAlter`; `administer annotation targets`).
- `annotations.target.delete_confirm` — `/…/targets/delete-confirm` (`TargetDeleteConfirmForm`; `administer annotation targets`).

## Config actions (`src/Plugin/ConfigAction/`)

For recipes / programmatic setup:
- `EnableTargetType` — opts an entity type into `enabled_target_types`.
- `EnableTargetField` — creates/updates an `annotation_target` and adds a field to its scope.
Used by the shipped recipes under `recipes/` (`annotations_demo_umami`, `annotations_demo_lgd`, `annotations_demo_webform`, `annotations_demo_types`).

## Hooks (`src/Hook/AnnotationsHooks.php`)

- `annotation_target_delete` / `annotation_type_delete` → cascade-delete annotation rows (skipped during uninstall).
- `theme` → `annotations_status_icon` (glyph/label/modifier).
- `entity_type_alter` → registers the `fields` form on `annotation_target`.
- `views_data` → derived `target_label` / `field_label` / `type_label` fields + filters on `annotation_field_data`.

## Install (`annotations.install`)

`hook_uninstall()` purges orphan `content_moderation_state` records for the `annotation` entity type (works around a core bug where non-current revision moderation records survive normal deletion).
