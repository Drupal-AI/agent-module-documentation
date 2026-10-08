<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Selecting the vertical display

The module has **no configuration page** (`configure: null`). You turn it on per
entity-reference field by choosing its display plugin on that field's Entity Browser
widget.

## Via the UI

1. Go to the entity's *Manage form display* (e.g. `admin/structure/types/manage/article/form-display`).
2. The reference field must use the **Entity browser** widget
   (`entity_browser_entity_reference`). Click its gear/cog.
3. Set **Entity display plugin** to **"Entity label, stacked vertically"**.
4. *Update*, then *Save*.

## Where it is stored

It is an ordinary widget setting (not a third-party setting) on the component inside the
`entity_form_display` config entity:

```yaml
# core.entity_form_display.node.article.default
content:
  field_ref:
    type: entity_browser_entity_reference
    settings:
      entity_browser: <some_entity_browser_id>
      field_widget_display: entity_browser_vertical_label   # <-- this is the switch
      # ... other entity_browser widget settings ...
```

## Setting it programmatically

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$component = $fd->getComponent('field_ref');
$component['settings']['field_widget_display'] = 'entity_browser_vertical_label';
$fd->setComponent('field_ref', $component)->save();
```

The value `entity_browser_vertical_label` is the plugin id; any other value (e.g. `label`,
`rendered_entity`) leaves the default horizontal layout. The `entity_browser` widget
setting must name an existing Entity Browser config entity for the widget to render, but
the vertical layout is triggered solely by the `field_widget_display` value.
