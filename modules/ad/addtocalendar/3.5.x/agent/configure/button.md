<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the "Add to Calendar" button

There is **no settings page** (`configure: null`). You configure the button in one of two places.

## Option A — third-party setting on a date field formatter

Works on any core **`datetime`** or **`daterange`** field. The module adds a settings section to
those formatters via `hook_field_formatter_third_party_settings_form()`.

UI: *Manage display* for the bundle → open the date field's formatter cog → tick **Show Add to
Calendar** → fill the settings → **Update** → **Save**.

Stored on the **entity view display** config entity:

```yaml
# core.entity_view_display.<entity>.<bundle>.<mode>
content:
  field_event_date:
    type: datetime_default            # or daterange_default, etc.
    third_party_settings:
      addtocalendar:
        addtocalendar_show: 1
        addtocalendar_settings:
          style: blue                 # 0 (none) | blue | glow_orange
          display_text: 'Add to Calendar'
          atc_title:        { field: title, tokenized: 'Title' }
          atc_description:  { field: token, tokenized: '[node:body]' }
          atc_location:     { field: field_venue, tokenized: 'Location' }
          atc_organizer:    { field: token, tokenized: 'My site' }
          atc_organizer_email: { field: token, tokenized: 'info@example.com' }
          atc_date_end:     { field: field_event_end, tokenized: '' }
          atc_privacy: public         # public | private
          data_secure: auto           # auto | true (https) | false (http)
          data_calendars:             # which providers appear in the dropdown
            'Google Calendar': 'Google Calendar'
            iCalendar: iCalendar
          multiple_value: 1           # 1 = single delta, 2 = all (multi-value fields)
          delta: 0                    # which delta shows the button when multiple_value=1
```

Each of `atc_title` / `atc_description` / `atc_location` / `atc_organizer` /
`atc_organizer_email` / `atc_date_end` is a `{ field, tokenized }` pair: pick another field on
the entity, or set `field: token` and put a token/static string in `tokenized`, or `field: title`
to use the node title. `atc_date_start` is taken from the date field itself and is not offered on
the formatter setting (it is only offered on the standalone field type).

Enable it in code:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.event.default');
$c  = $vd->getComponent('field_event_date');           // a datetime/daterange formatter
$c['third_party_settings']['addtocalendar']['addtocalendar_show'] = 1;
$c['third_party_settings']['addtocalendar']['addtocalendar_settings']['style'] = 'blue';
$vd->setComponent('field_event_date', $c)->save();
```

Read it back: `drush cget core.entity_view_display.node.event.default content.field_event_date`.

## Option B — the dedicated `add_to_calendar_field` field type

Adds a standalone button field to any entity (and to Views). It extends core's boolean item, so the
per-item value is a checkbox ("Show add to calendar widget") the editor can toggle per node.

- Field type id: **`add_to_calendar_field`**
- Default widget: **`add_to_calendar_widget_type`**
- Default formatter: **`add_to_calendar`**

Add it like any field:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_event_button', 'entity_type' => 'node', 'type' => 'add_to_calendar_field',
])->save();
FieldConfig::create([
  'field_name' => 'field_event_button', 'entity_type' => 'node', 'bundle' => 'event',
  'label' => 'Add to calendar',
])->save();
```

The button's title/description/location/dates/organizer and `style` (defaults to `glow_orange`),
privacy, security and calendar list are configured on the **field settings** form
(`defaultFieldSettings()` → `addtocalendar_show` + `addtocalendar_settings`), plus `on_label`
(display text) and `off_label` (disabled text). This lets you place a button on entities that have
no date field, and reuse it as a Views field.

## Styles & library

The addtocalendar.com JS (`//addtocalendar.com/atc/1.5/atc.min.js`) and base CSS load via the
`addtocalendar/base` library, attached automatically when a button renders. Style libraries:
`addtocalendar/blue` and `addtocalendar/glow_orange`. Choosing "No Styling" (`style: 0`) emits the
markup without a style library so you can add your own CSS.

## Default config object

`addtocalendar.settings` (schema `addtocalendar.settings`) ships install defaults (`style: blue`,
`display_text`, `atc_privacy: public`, `data_secure: auto`, …). The live per-display settings above
override these; the config object is the seed of default values, not an admin form.
