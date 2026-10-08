<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Widget (layout_builder_widget) — agent index

Exposes core Layout Builder's per-entity **override** UI as a **field widget** (`layout_builder_widget`)
for the `layout_section` field type, so editors arrange sections/blocks inline on the entity edit form
instead of on the separate Layout tab — and can do it on a **new, unsaved** entity. Depends on core
`layout_builder`. Core `^10.3 || ^11.0`, PHP >= 8.1. GPL-2.0-or-later. No permissions, no Drush commands.

## What it actually does
- Registers one field widget, `layout_builder_widget`, in
  `src/Plugin/Field/FieldWidget/LayoutBuilderWidget.php` (`field_types: ['layout_section']`,
  `multiple_values: TRUE`). Set it as the layout field's widget on *Manage form display*.
- Subclasses core's `overrides` section storage
  (`src/Plugin/SectionStorage/OverridesSectionStorage.php`) and swaps it in via
  `hook_layout_builder_section_storage_alter`. The subclass gives **new** entities a UUID-based
  storage id / tempstore key and can derive contexts from a UUID route value.
- `src/Routing/RouteSubscriber.php` widens the `layout_builder.overrides.<type>.view` route's entity
  parameter pattern to also match a UUID (needed for new-entity layouts).
- `hook_install` + `field_storage_config_presave` make the `layout_section` field storage
  **translatable** — this is what enables a per-translation layout (core does not support it by default).
- Rewrites Layout Builder's hard-coded `#layout-builder` DOM id to a per-storage hash
  (`ElementInfoAlterHook` pre-render + `AjaxRenderAlterHook`) so **multiple** Layout Builder instances
  (e.g. Paragraphs) can share one form. IDs come from `StorageIdentifier` (md5 of `type.id`/`type.uuid`).
- Removes core's hook that hides the layout field on the form-display UI (`hook_module_implements_alter`
  in `.module` + `FormEntityFormDisplayEditFormAlterHook` with `#[RemoveHook]`).
- Suppresses the "You have unsaved changes." warning (`EventSubscriber/SuppressUnsavedChangesMessageSubscriber.php`).
- Removes the redundant Layout Builder local-task tab when the widget is enabled on a bundle
  (`MenuLocalTasksAlterHook`).

## Widget settings (per Manage form display, all default TRUE)
`discard_changes`, `revert_overrides`, `toggle_content_preview` — see `agent/fields/widget.md`.
Config schema: `field.widget.settings.layout_builder_widget` (booleans). Value object: `WidgetSettings`.

## Actions (strategy pattern)
`Discard changes` (delete tempstore) and `Revert to defaults` (replace overrides with default sections)
are `WidgetActionHandlerInterface` handlers in `ActionHandlerRegistry`. Add a custom action by
registering a handler service and calling `addHandler` on `layout_builder_widget.action_handler_registry`.
`WidgetAction` is a backed enum. See `agent/hooks/hooks.md` for the full alter surface.

## Access
No new permissions. `EntityFieldAccessAlterHook` aligns edit access to the layout field with the
section storage's own `access()` result; who may change a layout stays governed by Layout Builder's
permissions. New-entity layouts are keyed in a **shared** tempstore by `entitytype.uuid`.

## Pairs with
`layout_builder_formatter` (display placement of the layout output) and conceptually with
`layout_builder_quick_add`. Save semantics differ from core's two-step tab flow — verify revision,
validation-error, and unsaved-changes behaviour on your bundle.
