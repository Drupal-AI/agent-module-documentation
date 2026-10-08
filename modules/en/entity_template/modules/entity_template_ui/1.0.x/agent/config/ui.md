<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, forms, access & services

## Enable

`drush en entity_template_ui` (enables `entity_template` too). No config schema and no
permissions of its own; it reuses the base module's `administer template builders` /
`administer template blueprints` and the config entities' `admin_permission`.

## Admin entry points (`entity_template_ui.routing.yml`)

- `/admin/content/entity_template` — menu landing (`_permission: access administration pages`).
- `/admin/content/entity_template/builder` — builder collection
  (`_permission: administer template builders`).
- `/admin/content/entity_template/builder/manage/{builder}/edit_default_blueprint` — edit a
  builder's default blueprint (`administer template builders`).
- Builder/blueprint add/edit/canonical/collection link templates are set in
  `entity_template_ui_entity_type_build()` (base entity types get `TemplateBuilderForm`,
  `TemplateBlueprintForm`, `TemplateBlueprintListBuilder`, and route providers).

## Blueprint editing routes

A large family of routes under
`/entity_template/blueprint/{template_blueprint_provider}/{blueprint_storage}/…` add, choose,
configure, swap, remove templates, components and conditions. All are
`options: { _admin_route: TRUE }`, all require **`_blueprint_storage_access: 'view'`**, and the
`blueprint_storage` parameter is upcast from a **shared tempstore** (`blueprint_tempstore: TRUE`)
so an in-progress blueprint can be assembled before it is saved back to config.

## Access check

`BlueprintStorageAccessCheck` (`src/Access/`, service
`access_check.entity_template.blueprint_storage_access`, tag `access_check` `applies_to`
`_blueprint_storage_access`) reads the route's operation and returns
`$blueprint_storage->access($operation, $account, TRUE)` — i.e. it defers to the blueprint
storage / config entity's own access, which for config blueprints is `administer template
blueprints`.

## Services (`entity_template_ui.services.yml`)

- `access_check.entity_template.blueprint_storage_access` — the access check above.
- `entity_template_ui.template_ui_factory` (`TemplateUIFactory`, arg `@class_resolver`) —
  builds the UI wrapper for a template plugin (`BaseTemplateUI`, `BlueprintTemplateUI`,
  `InlineTemplateUI`).

## Forms & elements

- `src/Form/`: `TemplateBuilderForm`, `TemplateBlueprintForm`, `AddTemplateForm`,
  `ConfigureTemplateForm`, `RemoveTemplateForm`, `AddComponentForm`, `SwapComponentForm`,
  `RemoveComponentForm`, `AddConditionForm`, `ConfigureConditionForm`, `RemoveConditionForm`;
  helper traits `TemplateAjaxFormHelperTrait`, `TemplateUIHelperTrait`, `ComponentFormBase`.
- `src/PluginForm/`: template/component/inline-template add & configure PluginForms attached in
  `entity_template_ui.module` via `hook_entity_template_alter()` /
  `hook_entity_template_component_alter()`.
- `src/Element/AvailablePlaceholders.php`: the `available_placeholders` render element that
  lists placeholders/filters for a component's contexts (used by
  `StringFieldWidgetInputComponent::buildConfigurationForm`).
- `src/Plugin/TypedDataFormWidget/EntityInputWidget.php` + `TypedDataFormWidgetManager` — a
  typed-data form widget used when collecting entity input.
- `EntityTemplateUiServiceProvider`, `AutocompleteController`, `Controller/BuilderController`,
  `ChooseTemplateController`, `ChooseComponentController`, `ChooseConditionController`,
  `TemplateBuilderDefaultBlueprintController`.

## Menu / action links

`entity_template_ui.links.menu.yml` places "Templates" under Content with "Builders" and
"Blueprint" children; `entity_template_ui.links.action.yml` adds "Add Builder" and
"Add Blueprint" actions. JS assets in `js/` (`autocomplete.js`, `triggerSubmit.js`) via
`entity_template_ui.libraries.yml`.
