<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three field widgets

The module **defines no plugin type**; it only adds `@FieldWidget` plugins for
`entity_reference_revisions` fields. All three share `ParagraphsPreviewerWidgetTrait`.

| Plugin id | Label | Extends | Use |
|---|---|---|---|
| `paragraphs_previewer` | Paragraphs Previewer | `Drupal\paragraphs\Plugin\Field\FieldWidget\ParagraphsWidget` | **The one to use.** Modern Paragraphs widget + preview button. |
| `entity_reference_paragraphs_previewer` | Paragraphs Previewer with Paragraphs Legacy | `…\InlineParagraphsWidget` | For sites still on the legacy `entity_reference_paragraphs` widget. |
| `paragraphs_previwer` | DEPRECATED Paragraphs Previewer | `ParagraphsPreviewerWidget` | Misspelled legacy id, kept only for BC. Removed from the widget dropdown by `paragraphs_previewer_form_entity_form_display_edit_form_alter()`. |

## What the trait changes

```php
defaultSettings()   // parent settings + edit_mode = 'closed' (PARAGRAPHS_PREVIEWER_DEFAULT_EDIT_MODE)
settingsSummary()   // prepends 'Previewer: Enabled'
formMultipleElements()  // attaches library paragraphs_previewer/widget
formElement()       // injects the 'Preview' submit button into the row
isPreviewerEnabled($mode)  // FALSE when the row's paragraphs mode is 'remove'/'removed'
```

The button is placed into `$element['top']['actions']['actions']` (modern widget), falling back
to `$element['top']['links']` (legacy widget) and then `$element['top']`. It carries
`#weight => -99999`, `#access => $paragraph->access('view')`, `#limit_validation_errors` scoped
to the field's `add_more`, and `#attached` library `paragraphs_previewer/dialog`.

## Subclassing

To add previewing to your own Paragraphs widget subclass, `use ParagraphsPreviewerWidgetTrait;`
and declare `const PARAGRAPHS_PREVIEWER_DEFAULT_EDIT_MODE = 'closed';` — that is the entire
contract (see `ParagraphsPreviewerWidget` for the 30-line reference implementation).

## Libraries

| Library | Contents |
|---|---|
| `paragraphs_previewer/dialog` | `js/dialog.js` + `css/dialog.css`, depends on `core/drupal.dialog.ajax`, jQuery UI resizable/draggable |
| `paragraphs_previewer/widget` | `css/paragraphs_preview.widget.css` (button styling in the widget) |
| `paragraphs_previewer/preview-page` | `css/preview_page.css`, attached by the preview controller |
