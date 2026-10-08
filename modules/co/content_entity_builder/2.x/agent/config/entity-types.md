<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building & operating a content entity type

## Install
`drush en content_entity_builder`. Grant `administer content entity types` (restrict-access) to
trusted admins only — it gates the entire builder and export UI.

## The config entity
`Entity\ContentType` (`@ConfigEntityType id="content_type"`, config prefix
`content_entity_builder.content_type`, admin permission `administer content entity types`). Exported
config keys: `id`, `label`, `keys`, `paths`, `applied`, `basefields`, `hook_theme`, `mode`. Schema:
`config/schema/content_entity_builder.schema.yml`. Base fields are a plugin collection
(`basefields` → `BaseFieldConfigPluginCollection`), so `ContentType` implements
`EntityWithPluginCollectionInterface`.

## Modes (chosen once, on the Add form)
`ContentTypeAddForm` offers `basic | basic_plus | advanced | full`. `Hook\ContentEntityBuilderHooks::entityTypeBuild()`
maps mode → runtime class + capabilities:
- `basic` — class `Entity\Content`, one base table, no bundles, not translatable.
- `basic_plus` — `Entity\Content` + a `<id>_type` config bundle entity, `permission_granularity=bundle`.
- `advanced` — class `Entity\AdvancedContent`, translatable, `<id>_field_data` table, adds owner/changed/published + bundles.
- `full` — class `Entity\FullContent` (extends `EditorialContentEntityBase`), adds revision tables + `show_revision_ui`.

## Workflow (`ContentTypeEditForm`, route `entity.content_type.edit_form`)
1. Add base fields (label + machine name + field type) — see `plugins/base-field-config.md`. Adding a
   field redirects to its config form (`content_entity_builder.base_field_edit_form`).
2. Under **Entity type settings**: set **entity keys** (`id`, `uuid`, and per mode `bundle`, `langcode`,
   `published`, `owner`, `revision`, plus a `label` chosen from an existing base field) and **entity
   paths** (`add`, `view`, `edit`, `delete`; must start with `/`; an `/admin` prefix renders in the admin
   theme). Key/path fields that already hold data are disabled (`$has_data`).
3. Submit **"Save and apply updates"** → `ContentTypeEditForm::save()` sets `applied=TRUE`, clears cached
   entity/field definitions, walks `entityDefinitionUpdateManager()->getChangeList()` and calls
   `entity_type.listener::onEntityTypeCreate/onEntityTypeUpdate` / `updateFieldableEntityType()` to create
   or update the storage schema, then rebuilds routes and clears discovery cache. Only `applied` types are
   registered (`entityTypeBuild()` skips `!$type->isApplied()`).

Add-form validation (`ContentTypeAddForm::validateForm`) rejects a machine name that collides with an
existing entity type id or an existing DB table. The id/field machine names use `#type => machine_name`.

## Routes & permissions
`Routing\ContentEntityBuilderRoutes::routes()` adds, per applied type, dynamic routes named
`entity.<id>.canonical|add_form|add_page|add|edit_form|delete_form|collection|admin_form` (bundle routes
`entity.<id>_type.*` for non-basic modes). Content routes are gated by the per-type permissions from
`ContentEntityBuilderPermissions`:
- `basic`/`basic_plus`: `access|create|edit any|delete any <type> content entity`.
- `advanced`/`full`: also `edit own|delete own <type> content entity`.
View route → `access <type> content entity`; edit/delete → `_entity_access` via
`ContentEntityBuilderAccessControlHandler` (maps update→edit, checks any/own owner). Management/bundle
routes require `administer content entity types`. Set these at `admin/people/permissions`. Manage
form/view display via the standard Field UI (`field_ui_base_route` points at the type's admin/bundle form).

## Delete / uninstall
`ContentType::delete()` calls `entityDefinitionUpdateManager()->uninstallEntityType()` for applied types
(dropping their tables) before removing the config entity.
`ContentEntityBuilderUninstallValidator` blocks uninstalling the module while content types still exist.
