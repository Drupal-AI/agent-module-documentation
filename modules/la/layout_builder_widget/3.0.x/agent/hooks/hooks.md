<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, services and how it rewires core Layout Builder

Almost all logic is OOP: `#[Hook]` attribute classes in `src/Hook/`, autowired services in
`layout_builder_widget.services.yml`. The `.module` file only holds thin `#[LegacyHook]` shims that
delegate to the service classes, plus a procedural `hook_module_implements_alter`
(`#[LegacyModuleImplementsAlter]`) that unsets `layout_builder`'s
`form_entity_form_display_edit_form_alter` implementation.

## Hook implementations (`src/Hook/`)
- **`LayoutBuilderSectionStorageAlterHook`** — `hook_layout_builder_section_storage_alter`: swaps the
  `overrides` section storage class to this module's `OverridesSectionStorage`. Central to everything.
- **`FormEntityFormDisplayEditFormAlterHook`** — a `#[RemoveHook]` class that removes core Layout
  Builder's `formEntityFormDisplayEditFormAlter` so the layout field is not hidden on *Manage form
  display* (belt-and-suspenders with the `.module` `hook_module_implements_alter`).
- **`FieldWidgetInfoAlterHook`** — `hook_field_widget_info_alter`: pins the `layout_builder_widget`
  widget's `class` and `provider`.
- **`FieldStorageConfigPresaveHook`** — on presave of a `layout_section` field storage named
  `layout_builder__layout`, forces `setTranslatable(TRUE)`. Combined with `hook_install` (which
  re-saves all existing `layout_section` field storages) this makes layouts translatable.
- **`ElementInfoAlterHook`** — `hook_element_info_alter`: removes core's single-instance `#process`
  on the `layout_builder` element and adds a `#[TrustedCallback]` pre-render that sets a deterministic
  per-storage id. Skips `DefaultsSectionStorageInterface` (defaults admin UI).
- **`AjaxRenderAlterHook`** — `hook_ajax_render_alter`: rewrites AJAX `insert` commands whose selector
  is `#layout-builder` to the per-storage selector, so AJAX updates hit the right instance.
- **`EntityFieldAccessAlterHook`** — `hook_entity_field_access_alter`: for `edit` on the
  `layout_builder__layout` field, sets `$grants[':default']` to the section storage's own
  `access('edit', $account, TRUE)` result (with cacheability). Access remains Layout Builder's.
- **`MenuLocalTasksAlterHook`** — `hook_menu_local_tasks_alter`: removes the core
  `layout_builder.overrides.<type>.view` local-task tab for a bundle whose form display uses the widget.
- **`ThemeRegistryAlterHook`** — `hook_theme_registry_alter`: drops core's
  `layout_builder_preprocess_language_content_settings_table` preprocess (translation UI cleanup).
- **`HelpHook`** — `hook_help` for the module's help page.

## Section storage override (`src/Plugin/SectionStorage/OverridesSectionStorage.php`)
Extends core `OverridesSectionStorage`, implements `MutableStorageInterface` (`setStorageId()`).
- `getStorageId()` / `getTempstoreKey()`: for new entities return the injected `storageId` (falling
  back to `entitytype.uuid`); otherwise defer to core (`entitytype.id`).
- `getLayoutBuilderUrl()`: builds a UUID-based route URL for new entities; falls back to `<current>`
  when the route does not exist.
- `deriveContextsFromRoute()`: when core derives no contexts and the route value contains a `.`,
  loads the section storage from the **shared** overrides tempstore keyed `type.id` and derives entity
  + view-mode contexts from it (supports new-entity UUID routes).
- `handleTranslationAccess()`: overridden to a no-op pass-through — it returns core's `$result`
  unchanged, dropping core's block on editing overrides for non-default translations. This is the
  translation-support feature (still gated by the normal override/update permissions).

## Routing (`src/Routing/RouteSubscriber.php`)
Priority -120. Appends `|<UUID pattern>` to the entity parameter requirement on every
`layout_builder.overrides.<type>.view` route, so a UUID (new entity) is accepted alongside a real id.

## Services
- `layout_builder_widget.id_service` (`LayoutBuilderIdService` → `SectionStorageIdGeneratorInterface`):
  deterministic ids/hashes/selectors from `StorageIdentifier`.
- `layout_builder_widget.section_storage_builder` (`SectionStorageBuilder` →
  `SectionStorageBuilderInterface`): loads the `overrides` storage for an entity, pulls from / writes
  to the layout tempstore, sets the custom storage id on new entities.
- `layout_builder_widget.context` (`LayoutBuilderContextService`): extracts entity, storage id and
  action name from form state / user input; builds a `LayoutContext` value object.
- `layout_builder_widget.action_handler_registry` (`ActionHandlerRegistry`): strategy registry of
  `WidgetActionHandlerInterface` handlers, seeded with `DiscardChangesHandler` and
  `RevertOverridesHandler` via service `calls`.
- `SuppressUnsavedChangesMessageSubscriber`: on `LayoutBuilderEvents::PREPARE_LAYOUT`, deletes all
  warning messages and re-adds every one except "You have unsaved changes.".

## Extending with a custom action
Create a service implementing `WidgetActionHandlerInterface` (`getName()`, `supports()`, `handle()`),
then add it to the registry:

```yaml
my_module.action_handler.custom:
  class: Drupal\my_module\Service\ActionHandler\CustomHandler
  arguments: ['@layout_builder.tempstore_repository']

layout_builder_widget.action_handler_registry:
  calls:
    - [addHandler, ['@my_module.action_handler.custom']]
```

## Uninstall
`hook_uninstall` clears the `tempstore.shared.layout_builder.section_storage.overrides` key-value
store so no tempstore entry keeps referencing the overridden storage class after removal.
