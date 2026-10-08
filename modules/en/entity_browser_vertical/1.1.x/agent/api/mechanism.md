<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the vertical stacking works

Two pieces: a display plugin that makes the option selectable, and a form-alter hook that
restyles the current selection when that option is chosen.

## The display plugin

`src/Plugin/EntityBrowser/FieldWidgetDisplay/EntityBrowserVerticalEntityLabel.php`:

```php
/**
 * @EntityBrowserFieldWidgetDisplay(
 *   id = "entity_browser_vertical_label",
 *   label = @Translation("Entity label, stacked vertically"),
 *   description = @Translation("Displays entity with a label, stacked vertically.")
 * )
 */
class EntityBrowserVerticalEntityLabel extends EntityLabel {}
```

It is an empty subclass of Entity Browser's `EntityLabel` display plugin — it inherits the
label rendering and adds no behavior itself. Its only job is to register a second
selectable `field_widget_display` option whose **id** the hook can detect. It is an
`EntityBrowserFieldWidgetDisplay` plugin (annotation-discovered), not a Drupal field
formatter/widget.

## The form-alter hook

`entity_browser_vertical.module` implements
`hook_field_widget_complete_entity_browser_entity_reference_form_alter()` (fires for the
`entity_browser_entity_reference` widget only):

- Reads `$widget->getSetting('field_widget_display')`.
- Does nothing unless it equals `entity_browser_vertical_label`.
- When it matches:
  - adds CSS class `entity-browser-vertical` to `widget.current` `#attributes['class']`;
  - for each `widget.current.items[<delta>]`, prepends
    `<a href="#" title="Drag to re-order" class="tabledrag-handle"></a>` to the item's
    `display` element (`#prefix`);
  - attaches the `entity_browser_vertical/entity_browser_vertical` library.

## The library

`entity_browser_vertical/entity_browser_vertical` = `css/entity_browser_vertical.css` plus
`js/entity_browser_vertical.js`, depending on `core/tabledrag` and `core/once`. The CSS
lays each `.item-container` out as a flex row inside the `.entity-browser-vertical` list
(border, grey background, drag-handle spacing) so the selection reads as a vertical stack.

Net effect: choosing the plugin swaps Entity Browser's default horizontal chip row for a
vertical, tabledrag-style list. Stored field values and view/formatter output are
untouched — this only affects the edit-form selection UI.
