<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: `layout_builder_widget`

Defined in `src/Plugin/Field/FieldWidget/LayoutBuilderWidget.php` (extends `WidgetBase`).

```
#[FieldWidget(
  id: 'layout_builder_widget',
  label: 'Layout Builder Widget',
  field_types: ['layout_section'],
  multiple_values: TRUE,
)]
```

It applies only to the core `layout_section` field type — in practice the
`OverridesSectionStorage::FIELD_NAME` field (`layout_builder__layout`) that core Layout Builder adds
when "Allow each content item to have its layout customized" is enabled for a view display. It is a
widget, not a new field type: you enable Layout Builder overrides in core first, then choose this
widget on *Manage form display*.

## How to enable
1. Enable core Layout Builder for the bundle's view display and allow per-item customization
   (`admin/structure/types/manage/<bundle>/display`).
2. Enable this module. It removes core's hook that hides the layout field on the form-display UI, so
   the field becomes configurable at `admin/structure/types/manage/<bundle>/form-display`.
3. Set the layout field's widget to **Layout Builder Widget**. The Layout Builder canvas now renders
   inline on the entity edit form; saving the form saves the layout.

## Settings (`WidgetSettings` value object, config schema `field.widget.settings.layout_builder_widget`)
All are booleans defaulting to `TRUE`:

| Key | Form label | Effect |
| --- | --- | --- |
| `discard_changes` | Show discard changes action button | Renders a *Discard changes* submit button (AJAX) that deletes this layout's tempstore entry. |
| `revert_overrides` | Show revert overrides action button | Renders a *Revert to defaults* submit button that removes all override sections and re-appends the default layout's sections, then saves to tempstore. |
| `toggle_content_preview` | Show toggle content preview | Renders the core content-preview checkbox (id `layout-builder-content-preview`, `data-content-preview-id` scoped to the current user). |

`settingsSummary()` prints each as "Shown"/"Hidden". Defaults come from `WidgetSettings::defaults()`.

## Render / submit flow (for debugging)
- `formElement()` returns a container with a `#process` callback (`processLayoutBuilderWidget`) that
  calls `buildWidgetElement()`.
- `buildWidgetElement()` resolves the section storage via
  `SectionStorageBuilder::build($entity, $storage_id)` (the `$storage_id` comes from the widget's
  hidden `storage_id` field, read from user input by `LayoutBuilderContextService`), then renders a
  `#type => 'layout_builder'` element plus the action buttons, wrapped in a
  `<div id="…-ajax-wrapper" class="layout-builder-widget">` for AJAX replacement. A hidden
  `storage_id` field carries `$section_storage->getStorageId()`. Attaches the
  `layout_builder_widget/layout_builder_widget.styles` library.
- Action buttons use `#limit_validation_errors => []`, `#submit => actionsSubmit`, and an AJAX
  refresh (`ajaxRefresh`) that returns the widget wrapper subtree.
- `actionsSubmit()` extracts the action name from the button `#name`, resolves the layout context via
  `LayoutBuilderContextService::getContext()`, and dispatches to `ActionHandlerRegistry::handleAction()`,
  then `$form_state->setRebuild()`.
- `extractFormValues()` (only after validation is complete) rebuilds the section storage from the
  submitted `storage_id`, calls `$items->setValue($section_storage->getSections())`, deletes the
  tempstore entry, and adds a "The layout override has been saved." status message.

## New (unsaved) entities
For `$entity->isNew()`, the overridden `OverridesSectionStorage` returns a storage id / tempstore key
of `entitytype.uuid` (see `StorageIdentifier::fromEntity`), and `SectionStorageBuilder` calls
`setStorageId()` so the in-progress layout is stored in the **shared** Layout Builder overrides
tempstore under that UUID key until the entity is first saved.

## Multiple instances on one form
`ElementInfoAlterHook` removes core's single-instance `#process` on the `layout_builder` element and
adds a pre-render that overwrites the element id with a per-storage hash (`StorageIdentifier` md5),
and `AjaxRenderAlterHook` rewrites AJAX `insert` commands targeting `#layout-builder` to that unique
selector. This is what makes nested/Paragraphs layouts and several fields on one form work.
