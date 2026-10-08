<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations (annotations) — agent index

Base module of the **Annotations suite**. A data + API layer for attaching structured editorial notes ("annotations") to any part of a Drupal site. Version **2.0.0-alpha4**, core `^11.2`, license GPL-2.0-or-later. Depends on core **views**. No end-user UI of its own — that lives in the submodules below.

## What it provides

- **Entities** (see [entities/model.md](entities/model.md)):
  - `annotation` — content entity (`EditorialContentEntityBase` + `EntityOwnerTrait`): revisionable, translatable, publishable. Fields: `target_id`, `field_name` (`''` = bundle/overview level), `value` (string_long), `type_id` (bundle). No canonical label field — `Annotation::label()` computes `target › field › type`.
  - `annotation_target` — config entity (`annotations.target.{id}`, id = `{entity_type}__{bundle}`): records an opted-in scope + its in-scope `fields`.
  - `annotation_type` — config entity (`annotations.annotation_type.{id}`, bundle of `annotation`): editorial/technical/rules ship as config.
- **Target plugin type** `annotations_target` (see [plugins/targets.md](plugins/targets.md)): manager `plugin.manager.annotations_target` (`TargetPluginManager`), attribute `#[AnnotationsTarget]`, base `TargetBase`, catch-all `GenericTarget` + `GenericTargetDeriver`. Dedicated plugins: Node, TaxonomyTarget, RoleTarget, MediaTarget, MenuTarget, ViewTarget, ParagraphTarget, WorkflowTarget, UserTarget.
- **Storage API** `annotations.annotation_storage` (`AnnotationStorageService`, see [api/storage.md](api/storage.md)): the only sanctioned way to read/write annotation rows. Note the `''`→`IS NULL` sentinel handling.
- **Permissions** (`AnnotationsPermissions` + `annotations.permissions.yml`): static `administer annotations` / `administer annotation targets` / `administer annotation types` / `access annotation collection` / `edit any annotation` / `delete any annotation`; dynamic per type `consume {id} annotations` / `edit {id} annotations` / `delete {id} annotations`. Access handler: `AnnotationAccessControlHandler`.
- **Config & settings** (see [config/settings.md](config/settings.md)): `annotations.settings` (`use_accordion_single`), `annotations.target_types` (`enabled_target_types`). Schema in `config/schema/annotations.schema.yml`. Config actions `EnableTargetType` / `EnableTargetField`.
- **Drush** (`AnnotationsCommands`): `annotations:targets` (ann:targets), `annotations:types` (ann:types), `annotations:show` (ann:show), `annotations:stats` (ann:stats).
- **Views** integration (`AnnotationsHooks::viewsData`): derived fields/filters `target_label`, `field_label`, `type_label`; plus `argument`/`argument_validator`/`filter`/`field` plugins under `src/Plugin/views/`. Ships `views.view.annotations`.

## Routes (all admin, permission-gated)

`annotations.admin` `/admin/config/annotations` (administer annotations), `annotations.settings` `/…/settings`, `annotations.configure` `/…/types` + `entity.annotation_target.collection` `/…/targets` + `annotations.target.fields` + `annotations.target.delete_confirm` (administer annotation targets). Forms: `AnnotationsSettingsForm`, `TargetTypesForm`, `TargetOverviewForm`, `TargetFieldsForm`, `TargetDeleteConfirmForm`.

## Submodules (each documented at `modules/<name>/2.0.x/`)

- **annotations_ui** — annotate landing/add/edit UI, delete-all, revision history + diff. Core management UI.
- **annotations_type_ui** — CRUD UI for annotation types (site-building; uninstallable after).
- **annotations_overlay** — in-context help overlays on entity forms/views; per-user type hiding.
- **annotations_context** — assembles context payloads; JSON API, MCP endpoint (Bearer or session), admin preview/export.
- **annotations_audit** — site-structure scan (waypoints/drift) + annotation coverage report.
- **annotations_docs** — AI-generated documentation nodes per target (needs drupal/ai).
- **annotations_tool** — exposes annotations as Tool API plugins for function-calling agents (needs drupal/tool).
- **annotations_export** — Drush export of assembled context as markdown or an Obsidian vault.
- **annotations_explorer** — read-only explorer/browser for annotations.
- **annotations_webform** — Webform + WebformSubmission target plugins + submission-form overlays.
- **annotations_profile** — overlay injection into user/registration forms for Profile fields.
- **annotations_workflows** — attaches a content-moderation workflow to annotations; ships `workflows.workflow.annotations`.

## Notes for agents

- Annotation text is **content**, never config — it is not exported by `drush cim/cex`. Read it via `AnnotationStorageService`, not raw entity queries (sentinel handling).
- The suite's design deliberately splits **management** perms (base module) from **consumption** perms (per type). `edit any annotation` / `delete any annotation` are broad — trusted roles only.
- Annotation `value` is a plain `string_long` (not a formatted-text field); consumers escape it on output.
