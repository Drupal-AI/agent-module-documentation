<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable "Hide seconds" on a datetime field

The module has **no configure route** (`configure: null`) and no settings form. You enable it
per field, per form mode, on the entity's **Manage form display** page, or directly in the
`entity_form_display` config.

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: datetime_default          # or datetime_datelist / a daterange widget
    third_party_settings:
      datetimehideseconds:
        hide: true
```

The checkbox only appears for widgets extending `DateTimeWidgetBase` — i.e. the core Date/time
widgets `datetime_default` ("Date and time") and `datetime_datelist` ("Select list"), and the
Datetime Range widgets from the `datetime_range` module. It has no effect on a date-only field
(no time input to alter).

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. Article: `/admin/structure/types/manage/article/form-display`).
2. Click the gear/cog on the datetime field's row.
3. Tick **Hide seconds** (description: "This will have no effect if there is no time widget.").
4. **Update**, then **Save**. The widget summary then reads "Hide seconds."; otherwise "Do not hide seconds."

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$component = $fd->getComponent('field_event_date');          // must be a datetime widget
$component['third_party_settings']['datetimehideseconds']['hide'] = TRUE;
$fd->setComponent('field_event_date', $component)->save();
```

To turn it back off, set `hide` to `FALSE` (or unset the `datetimehideseconds` third-party
settings key) and save.

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_event_date
# look for third_party_settings.datetimehideseconds.hide: true
```

Or in PHP: `$fd->getComponent('field_event_date')['third_party_settings']['datetimehideseconds']['hide']`.

## Config schema

The module ships `field.widget.third_party.datetimehideseconds` with a single boolean `hide`,
so the value is validated as part of the form-display config.
