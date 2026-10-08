<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply a Field Timer formatter to a datetime field

There is no configure route. You select a formatter on a **datetime field's row** on the
entity's *Manage display* page; the choice is stored in the `entity_view_display` config
entity for that bundle + view mode.

## Where it is stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`
Component path within it:

```yaml
content:
  <field_name>:
    type: field_timer_simple_text        # or field_timer_countdown / _countdown_led / _county
    label: hidden
    settings:
      type: countdown                    # simple_text: auto | timer | countdown
    weight: 5
    region: content
```

The field must be a **`datetime`** field (all four formatters declare
`field_types = { datetime }`).

## Via the UI

1. Go to the bundle's *Manage display* (e.g. Article: `/admin/structure/types/manage/article/display`).
2. On the datetime field's row, choose one of **Text timer or countdown**, **jQuery
   Countdown**, **jQuery Countdown LED**, or **County** in the Format column.
3. Click the cog to set that formatter's options (e.g. Type = Timer/Countdown/Auto).
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_event_date', [
  'type' => 'field_timer_simple_text',
  'label' => 'hidden',
  'settings' => ['type' => 'timer'],
  'weight' => 5,
  'region' => 'content',
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_event_date
# content.field_event_date.type  -> field_timer_simple_text
# content.field_event_date.settings.type -> timer
```

Or in PHP: `$vd->getComponent('field_event_date')['type']` and `['settings']['type']`.

Note: the JS formatters (`field_timer_countdown`, `field_timer_countdown_led`,
`field_timer_county`) render but only animate in the browser when their external library is
present under `web/libraries/`. `field_timer_simple_text` needs no library.
