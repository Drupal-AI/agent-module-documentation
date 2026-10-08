<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tab content plugin type (`entity_ui_tab_content`)

## The plugin type

- Declared in `entity_ui.plugin_type.yml` (id `entity_ui_tab_content`,
  `plugin_manager_service_id: plugin.manager.entity_ui_tab_content`; the
  `plugin_definition_decorator_class` line integrates with the contrib **Plugin** module's admin
  listing but is not needed for core function).
- Manager: `src/Plugin/EntityTabContentManager.php` — a standard `DefaultPluginManager` scanning
  `Plugin/EntityTabContent`, interface `EntityTabContentInterface`, annotation
  `@EntityTabContent` (`src/Annotation/EntityTabContent.php`: `id`, `label`, `description`,
  `entity_types`). Alter hook `hook_entity_ui_entity_tab_content_info_alter()`
  (`entity_ui.api.php`). `createInstance()` requires the owning `EntityTab` and calls
  `setEntityTab()` on the instance.
- Interface `src/Plugin/EntityTabContentInterface.php`; base classes
  `src/Plugin/EntityTabContentBase.php` and (for form tabs) `src/Plugin/EntityTabContentFormBase.php`.

## Base class responsibilities (`EntityTabContentBase`)

- `appliesToEntityType()` — TRUE if the plugin's `entity_types` annotation is empty or lists the
  entity type.
- `getPermissions()` — expands a permission template into concrete permissions: per bundle (when
  the entity type's permission granularity is `bundle`) and per `any`/`own` (when the entity type
  implements `EntityOwnerInterface`). Template (`getPermissionTemplate()`):
  `"access <path> tab on %modifier %type-id %bundle-id entities"`.
- `access($target_entity, $account)` — combines a plugin **logic** check (`hasLogicAccess()`)
  with a **permission** check (`hasPermissionAccess()`). `hasPermissionAccess()` checks the
  account against the tab's own generated permission (matching the bundle, and for owner-aware
  types the `any` permission, else the `own` permission together with
  `account id == target owner id`). `hasLogicAccess()` is the intended extension point for a plugin
  to add its own applicability/entity-state checks (e.g. hide a "publish" tab on already-published
  entities).
- `buildContent($target_entity)` — abstract in effect; each plugin returns the tab's render array.

`EntityTabContentFormBase` makes a plugin double as a `FormInterface`: `buildContent()` returns
`formBuilder->getForm($this, $target_entity)`, and `getTargetEntity($form_state)` reads the entity
from build-info args.

## Shipped plugins (`src/Plugin/EntityTabContent/`)

- **`entity_view`** (`EntityView.php`) — config `view_mode` (default `default`);
  `buildContent()` = `getViewBuilder($type)->view($entity, $view_mode)`. Suggested path `view`.
- **`entity_form`** (`EntityForm.php`) — config `form_mode` (default `default`);
  `buildContent()` = `entity.form_builder->getForm($entity, $form_mode)` (hot-patches a missing
  form class to the default per core issue 2530086). Suggested path `edit`.
- **`owner_assign`** (`OwnerAssign.php`, extends `EntityTabContentFormBase`) — applies only to
  `EntityOwnerInterface` types; a `entity_autocomplete` user field; `validateForm()` checks the
  user exists (parameterised `queryRange` on `users_field_data`) and differs from the current
  owner; `submitForm()` sets the new owner and saves the entity.
- **`actions_configurable:*`** (`ActionsConfigurableAction.php` + deriver
  `Plugin/Derivative/ActionsConfigurableActionTabContentDeriver.php`) — one derivative per action
  plugin; `appliesToEntityType()` matches the action's `type` to the entity type. The tab renders
  the action plugin's configuration form (`buildForm()`), then `submitForm()` runs
  `actionPlugin->submitConfigurationForm()` and `actionPlugin->execute($target_entity)`. Suggested
  path derived from the action ID.

## Writing a custom plugin

Add a class in your module under `Plugin/EntityTabContent/` with `@EntityTabContent(id=…,label=…)`,
extend `EntityTabContentBase` (or `EntityTabContentFormBase`), implement `buildContent()`, and
override `defaultConfiguration()` / `buildConfigurationForm()` for settings and, where relevant,
`hasLogicAccess()` and `getPermissionTemplate()`. Add a
`entity_ui.content_config.plugin.<id>` schema entry for the stored `content_config`.
