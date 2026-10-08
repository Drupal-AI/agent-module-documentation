<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Entity Reference Views Select widgets

No settings page — you configure per field on the bundle's **Manage form display**.

## Prerequisites

The entity-reference field should use a **View** as its reference method:
1. On the field's *Field settings* (or the field edit form), set **Reference method** =
   *Views: Filter by an entity reference view*.
2. Pick the entity reference **View** and display. (These become the field's
   `handler_settings.view.view_name` / `display_name` / `arguments`.)

If the handler is not `views`, the widgets still work but fall back to a plain select/checkbox.

## Assign the widget (UI)

On *Manage form display* (`/admin/structure/types/manage/<bundle>/form-display`) pick, for the
field's widget:
- **Entity Reference Views Select list** → widget `erviews_options_select`, or
- **Entity Reference Views Check boxes/radio buttons** → widget `erviews_options_buttons`.

`erviews_options_select` has one setting, **Empty Value** (`empty_value`, default "- None -"),
shown for non-required fields. `erviews_options_buttons` renders radios for single-value fields
and checkboxes for multi-value fields (empty label "N/A" for optional single-value).

## Where it is stored

The choice is the widget `type` on the field's component in the form-display config:

```
core.entity_form_display.<entity>.<bundle>.<form_mode>
  content:
    <field_name>:
      type: erviews_options_select        # or erviews_options_buttons
      settings: { empty_value: '- None -' }   # select widget only
```

## Programmatic (drush php:eval)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setComponent('field_my_ref', [
  'type' => 'erviews_options_select',   // or erviews_options_buttons
  'settings' => ['empty_value' => '- None -'],
  'region' => 'content',
])->save();
```

## How rendering works

When the field handler is `views`, the widget loads and executes the referenced View with the
field's stored arguments, renders each result row via the View's row plugin, and uses that
markup as the option label keyed by the entity id. `sanitizeLabel()` strips tags for the select
widget. Nothing is cached or configured beyond the form-display component.
