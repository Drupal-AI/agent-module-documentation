<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suggestion config entity, admin UI, usage tracking

## The config entity
`src/Entity/TemplateWhispererSuggestionEntity.php` — a `ConfigEntityType` (PHP attribute) with
`id = template_whisperer_suggestion`, `config_prefix = template_whisperer_suggestion`,
`admin_permission = "administer template whisperer suggestion entities"`.

- `config_export`: `id`, `name`, `suggestion`.
- `name` — human-readable label shown in the field widget.
- `suggestion` — the machine name used to build theme suggestions.
- On save (`TemplateWhispererSuggestionForm::save()`) the entity **id is set to the suggestion
  machine name** (`$entity->id = trim($entity->suggestion)`), so id === suggestion.
- Validation (`TemplateWhispererSuggestionForm::validateForm()`): non-empty, not all underscores,
  matches only `[a-z0-9_]`, and unique across suggestions. This is what keeps the value safe to
  interpolate into a theme-hook string.
- `preDelete()` removes all usage-table rows for the deleted suggestion (but does not touch the
  `target_id` still stored on referencing content).

Config schema: `config/schema/template_whisperer.schema.yml`
(`template_whisperer.template_whisperer_suggestion.*` = id/name/suggestion).

## Admin UI (`template_whisperer.routing.yml`, all gated by `administer template whisperer suggestion entities`)
- `/admin/structure/template-whisperer` — list (`entity.template_whisperer_suggestion.collection`),
  linked from Structure menu. List builder shows Name, Suggestion, and "Used in" (usage count as a
  link to the usage page).
- `/admin/structure/template-whisperer/add` · `/{id}/edit` · `/{id}/delete` — CRUD forms. The delete
  form warns, with a link, when the suggestion is still used.
- `/admin/structure/template-whisperer/{id}` — canonical view.
- `/admin/structure/template-whisperer/{id}/usage` — `AdminSuggestionController::usage()`: a paged
  table of Entity / Entity type / Registering module / Count for every place the suggestion is used.

## Usage tracking (`src/TemplateWhispererSuggestionUsage.php`, `template_whisperer.install`)
Service `template_whisperer.suggestion.usage` (tagged `backend_overridable`) over the
`template_whisperer_suggestion_usage` table (columns: `sid`, `module`, `type`, `id`, `count`;
PK `sid,type,id,module`). Methods: `add()` (merge + increment), `delete()` (decrement/remove),
`listUsage()`, `countUsage()`. The field type's `postSave()`/`delete()` (see
[fields/field.md](../fields/field.md)) keep this table in sync as content is saved, updated,
translated and deleted.

## Install / update notes (`template_whisperer.install`)
- `hook_install()` rebuilds routes and shows a pointer message to the admin page.
- `update_8001` migrated existing roles to the `administer the template whisperer field` permission.
- `update_8002` deleted the legacy `views.view.template_whisperer` (listing is now the entity list builder).
