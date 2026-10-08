<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, schema, permissions & routes

## Install / enable

`composer require drupal/entity_template` (pulls contributed `typed_data`), then
`drush en entity_template`. Enable `entity_template_ui` too for the admin UI. The base
module ships **no default builder/blueprint** — nothing runs until you configure one.

## Config entities (`src/Entity/`)

- **`entity_template_builder`** (`TemplateBuilder`, `@ConfigEntityType`
  `config_prefix = "builder"`, `admin_permission = "administer template builders"`).
  `config_export`: `id`, `label`, `default_blueprint`, `return_type`, `parameters`.
  A builder declares the parameters the build asks for and the entity type it produces.
- **`entity_template_blueprint`** (`TemplateBlueprint`, `config_prefix = "blueprint"`,
  `admin_permission = "administer template blueprints"`). `config_export`: `id`, `label`,
  `builder`, `is_default`, `templates`. `templates` is a sequence of template plugin
  configurations; each template embeds a `components` sequence. `is_default = TRUE` marks a
  builder's default blueprint (used for default field values); non-default blueprints are the
  ones selectable in the build flow (`ConfigTemplateBlueprint::getAllBlueprints()` queries
  `builder == …` AND `is_default == FALSE`).

Link templates / entity routes (collection, add, canonical, edit) are attached by the UI
submodule in `entity_template_ui_entity_type_build()` — the base module alone has no admin
entity routes for these config entities.

## Schema (`config/schema/entity_template.schema.yml`)

- `entity_template.builder.*` → mapping with `id`, `label`, `description`,
  `default_blueprint`, `return_type`, `parameters` (sequence of `{machine_name,label,type}`).
- `entity_template.blueprint.*` → `id`, `label`, `builder`, `templates` (sequence of
  `entity_template.template.[id]`), `is_default`.
- `entity_template.template` → `id` (plugin id), `uuid`, `label`, `description`, `priority`,
  `conditions` (sequence of `condition.plugin.[id]`), `components` (sequence of
  `entity_template.component.plugin.[id]`), `target_entity_type_id`, `target_entity_bundle`.
- `entity_template.component.plugin` → `id`, `uuid`; a context-aware variant adds
  `context_mapping`; `entity_template.component.plugin.field.widget_input` adds `field_type`
  and a `value` sequence typed by the field (`field.value.[…field_type]`). This `value` is
  where a component's static input / token / Twig string is stored.

## Permissions (`entity_template.permissions.yml`)

- `administer template builders`
- `administer template blueprints`

These gate configuration of builders and blueprints (the config entities' `admin_permission`)
and, through the UI submodule's `_blueprint_storage_access` check
(`BlueprintStorageAccessCheck` → config-entity `access()`), the template/component editing
forms.

## Routes (`entity_template.routing.yml`) — the public build flow

All four use `options: { no_cache: 'TRUE' }`:

| Route | Path | Handler |
|-------|------|---------|
| `entity_template.select_builder` | `/entity_template/build` | `EntityTemplateController::selectBuilder` |
| `entity_template.select_builder_parameters` | `/entity_template/build/{builder_name}/parameters` | `BuilderParameterProvisionForm` |
| `entity_template.select_template_blueprint` | `/entity_template/build/{builder_name}/{session_key}/select` | `EntityTemplateController::selectTemplateBlueprint` |
| `entity_template.edit.entity_tempstore` | `/entity_template/build/{builder_name}/{session_key}/{blueprint_key}/edit` | `EntityTemplateController::displayEntityForm` |

See [../api/build-flow.md](../api/build-flow.md) for how these chain and where the entity is
created and saved. Admin config routes (builder/blueprint collections, add/edit, template &
component editing) live in the UI submodule — see
[../../../modules/entity_template_ui/1.0.x/agent/start.md](../../../modules/entity_template_ui/1.0.x/agent/start.md).
