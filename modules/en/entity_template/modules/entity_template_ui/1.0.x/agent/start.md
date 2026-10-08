<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Template UI (entity_template_ui) — agent index

Admin configuration UI for **Entity Template**. Attaches admin routes, entity forms, list
builders and menu/action links for the `entity_template_builder` and
`entity_template_blueprint` config entities, plus the step-by-step template/component editor.
Submodule of `entity_template` (dependency `entity_template:entity_template`). Core
`^9.1 || ^10 || ^11`. GPL-2.0-or-later. Version dir 1.0.x (installed 1.0.0-alpha17).

Parent module docs: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)

- **Routes, forms, access check, services, hooks** → [config/ui.md](config/ui.md)

## What it actually is (from source)

- **Hooks** (`entity_template_ui.module`): `hook_entity_type_build()` sets route providers,
  link templates and default form classes on both config entity types (so their add/edit/
  collection routes exist); `entity_template_ui_entity_template_alter()` and
  `entity_template_ui_entity_template_component_alter()` attach add/configure PluginForms and
  `ui_class` to the default template and to `InlineTemplate`.
- **Routing** (`entity_template_ui.routing.yml`): `/admin/content/entity_template`
  (`access administration pages`); builder collection & default-blueprint editor
  (`administer template builders`); and a family of
  `/entity_template/blueprint/{provider}/{blueprint_storage}/…` template/component/condition
  editing routes gated by `_blueprint_storage_access: 'view'` with the `blueprint_storage`
  param converted from a shared **`blueprint_tempstore`**.
- **Access** (`entity_template_ui.services.yml`): `access_check.entity_template.blueprint_storage_access`
  (`BlueprintStorageAccessCheck`, tag `access_check` applies_to `_blueprint_storage_access`) →
  delegates to `blueprint_storage->access($operation)`; `entity_template_ui.template_ui_factory`
  (`TemplateUIFactory`).
- **Forms** (`src/Form/`, `src/PluginForm/`): `TemplateBuilderForm`, `TemplateBlueprintForm`,
  Add/Configure/Remove for templates, components (incl. swap) and conditions, plus inline-template
  add/configure forms; AJAX helper trait `TemplateAjaxFormHelperTrait`.
- **Element**: `available_placeholders` render element (`src/Element/AvailablePlaceholders.php`)
  listing usable placeholders/filters for a component's contexts.
- **Also**: `EntityInputWidget` (TypedDataFormWidget) + `TypedDataFormWidgetManager`,
  list builder `TemplateBlueprintListBuilder`, autocomplete controller, service provider
  `EntityTemplateUiServiceProvider`. No own permissions; no config schema.
