<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# efs config entity, schema, hooks & Field UI integration

## The `extra_field` config entity

`src/Entity/ExtraField.php` (`@ConfigEntityType id = "extra_field"`, `config_prefix = "extra_field"`,
`admin_permission = "administer site configuration"`). One entity = one placement. Stored/exported
keys (`config_export`): `id`, `label`, `field_name`, `entity_type`, `bundle`, `context`, `mode`,
`plugin`, `weight`, `settings`.

- The **id is composite**, built on save as `entity_type.bundle.context.mode.field_name`
  (`ExtraFieldForm::save()` / `ExtraFieldAddForm::submitForm()`); `field_name` equals the entered
  machine name.
- `context` is `display` (view display) or `form` (form display).
- Accessors: `getTargetEntityTypeId()`, `getBundle()`, `getContext()`, `getMode()`, `getName()`,
  `getPlugin()`, `getSettings()` / `getSetting()` / `setSettings()` / `setSetting()`, `composedId()`.
- Handlers: list builder `ExtraFieldListBuilder`, forms `ExtraFieldForm` (add/edit) +
  `ExtraFieldDeleteForm`, route provider `ExtraFieldHtmlRouteProvider`.

## Config schema

`config/schema/extra_field.schema.yml` defines `efs.extra_field.*.*.*.*.*` (type `config_entity`):
`id`, `label`, `uuid`, `plugin`, `weight` (integer), `entity_type`, `bundle`, `context`, `mode`,
`field_name`, and `settings` (type `map` — free-form per plugin). A specialised variant
`efs.extra_field.*.*.*.tokenizer_wysiwyg.*` types `settings.content` as `text_format`. This is why
`provides_config_schema` is true.

## Routes & access (important)

`ExtraFieldHtmlRouteProvider::getRoutes()` extends `AdminHtmlRouteProvider` but then **sets
`_access = 'FALSE'` on every generated route except `entity.extra_field.delete_form`** — so the
`/admin/structure/extra_field*` canonical/add/edit/collection pages are intentionally disabled. Extra
fields are managed instead through Field UI (below). The delete form stays reachable and is linked
from the Field UI row.

`RouteSubscriber` (`efs.subscriber`, `src/Routing/RouteSubscriber.php`, priority -210) adds four
"add extra field" routes per fieldable entity type, hung off each type's `field_ui_base_route`:

- `field_ui.efs_add_<type>.form_display` / `.form_mode` (context `form`) — require
  `administer <type> form display`.
- `field_ui.efs_add_<type>.display` / `.view_mode` (context `view`) — require
  `administer <type> display`.

All point to `ExtraFieldAddForm`. Local actions ("Add extra field") are derived by
`Plugin/Derivative/EfsLocalAction.php` and appear on the Manage display / Manage form display forms
(`efs.links.action.yml`, `efs.action.yml`). `efs.param_converter` (`ExtraFieldConverter`, type `efs`)
is registered but its `convert()` is effectively a no-op (returns `[]` for a valid 5-part id).

## Add / edit / delete forms

- `ExtraFieldAddForm` (FormBase, `extra_field_add_form`): resolves mode from
  `view_mode_name`/`form_mode_name` request params (default `default`); lists only plugins whose
  `supported_contexts` include the context **and** whose `isApplicable()` returns TRUE; creates the
  `ExtraField`, invalidates the `entity_field_info` cache tag, and redirects to the matching Field UI
  route (`getFieldUiRoute()`).
- `ExtraFieldForm` (EntityForm): plain add/edit of entity type / bundle / context / mode / label /
  machine name / plugin.
- `ExtraFieldDeleteForm` (EntityConfirmFormBase): confirm-delete, invalidates `entity_field_info`.

## Hooks (`efs.module`)

- `hook_entity_extra_field_info()` — `efs_entity_extra_field_info()` loads all `ExtraField` entities
  (statically cached) and registers each as an extra field
  `$data[entity_type][bundle][context][field_name_mode]` with label/weight/visible/mode/plugin/id,
  sorted by weight (`efs_sort_by_weight`).
- `hook_entity_view_alter()` — `efs_entity_view_alter()` iterates the `display` context extra fields,
  matches the current view mode (or `default`↔`full`), instantiates the plugin, applies stored
  settings (or `defaultContextSettings()`), calls `view()`, and sets
  `$build[$name] = result + ['#cache' => ['max-age' => PERMANENT], '#weight' => component weight]`.
- `hook_form_alter()` — `efs_form_alter()` does the same for `ContentEntityFormInterface` forms
  (context `form`).
- `hook_entity_presave()` — `efs_entity_presave()` on `EntityDisplayInterface` unsets extra-field
  components that belong to a different mode (skips Layout Builder-enabled displays).
- `hook_form_FORM_ID_alter()` for `entity_view_display_edit_form` and
  `entity_form_display_edit_form` load `includes/field_ui.inc` and call
  `efs_field_ui_display_form_alter()`.
- `hook_block_alter()` — `efs_block_alter()` removes the core Layout Builder `extra_field_block`
  derivative for efs fields (see the LB override note below).
- `hook_module_implements_alter()` — moves efs's `form_alter` / `entity_view_alter` to run last.
- `hook_theme()` — registers an `efs` theme hook (`templates/efs.html.twig`, currently an empty
  placeholder).

## Field UI integration — `includes/field_ui.inc`

`efs_field_ui_display_form_alter()` reworks the Manage display / Manage form display table for efs
rows: removes rows for other modes, injects a settings-edit (cog) button and a delete link
(`entity.extra_field.delete_form` with a `destination`), and — when a row is being edited — renders
the plugin's `settingsForm()` inline with Update/Cancel AJAX buttons (reusing Field UI's
`multistepSubmit`/`multistepAjax`). `efs_formatter_settings_update()` pulls `weight` out of the
submitted settings, saves it on the entity, and stores the remaining values via
`ExtraField::setSettings()->save()`. Helpers: `efs_format_settings_form()`,
`efs_format_settings_summary()`, `efs_get_plugin_label()`, `efs_get_extra_fields()`,
`efs_field_ui_form_params()`, `efs_get_context_from_display()`.

## Layout Builder

`src/Plugin/Block/ExtraFieldBlock.php` extends `layout_builder`'s `ExtraFieldBlock` so an efs field
placed in a Layout Builder region can be configured (its `blockForm()` reuses the plugin
`settingsForm()`; `blockSubmit()` saves settings back to the `ExtraField`). It is registered via
`efs_block_alter()` rather than auto-discovery. Note: in the current 3.0.x source `efs_block_alter()`
`unset()`s the derivative (the class-swap line is commented out) and `ExtraFieldBlock::build()`
returns `#access = FALSE`; Layout Builder support is documented by the project as incomplete
(`data.json` project_description references issues #3046144 / #3045802).

## Install

`efs.install`: `efs_install()` and update `efs_update_8101()` both `module_set_weight('efs', 999)` so
efs's alter hooks run after other modules. No schema/tables, no permissions file.
