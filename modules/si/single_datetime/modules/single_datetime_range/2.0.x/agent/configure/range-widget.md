<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Single DateTimePicker on a Datetime Range field

`single_datetime_range` has **no configure route** (`configure: null`) and no settings form of its
own. You enable it per field, per form mode, by choosing its widget on the entity's **Manage form
display** page (or by editing the `entity_form_display` config directly).

## The widget

- Plugin id: **`single_date_time_range_widget`** (label "Single Date Time Picker").
- Applies to core **`daterange`** fields (the Datetime Range field type from `datetime_range`).
- Class: `Drupal\single_datetime_range\Plugin\Field\FieldWidget\SingleDateTimeRangeWidget`,
  extends `Drupal\single_datetime\Plugin\Field\FieldWidget\SingleDateTimeBase`.
- Renders **both** the start (`value`) and end (`end_value`) inputs as `single_date_time` elements
  wrapped in a fieldset, and validates start ≤ end (`validateSingleDateTime`).

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`

```yaml
content:
  <field_name>:
    type: single_date_time_range_widget
    settings:
      hour_format: '24h'        # '12h' or '24h' (default '24h')
      allow_seconds: false
      allow_times: '15'         # 5 | 10 | 15 | 30 | 60 minutes granularity (default '15')
      allowed_hours: ''         # e.g. '8,9,10,11,12,13,14,15,16,17'
      disable_days: {  }        # values 1..7 = Mon..Sun
      exclude_date: ''          # d.m.Y per line, e.g. 31.12.2025
      inline: false
      mask: false
      datetimepicker_theme: 'default'   # 'default' | 'dark'
      start_date: ''
      min_date: ''
      max_date: ''
      year_start: ''
      year_end: ''
      allow_blank: false
```

The settings are inherited unchanged from `SingleDateTimeBase::defaultSettings()` and apply to both
the start and end inputs. For the full meaning of each key see the parent doc
`../../../../../2.0.x/agent/configure/widget-settings.md`.

## Via the UI

1. Add or edit a **Datetime Range** field on a content type (field type "Date range").
2. Go to that bundle's *Manage form display*.
3. In the field's **Widget** column choose **Single Date Time Picker**.
4. Click the gear/cog to set hour format, minute granularity, disabled days, etc.
5. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
// A daterange field field_period must already exist on node.<bundle>.
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');           // get-or-create the form display
$fd->setComponent('field_period', [
  'type' => 'single_date_time_range_widget',
  'weight' => 20,
  'region' => 'content',
  'settings' => ['hour_format' => '12h', 'allow_times' => '30'],
])->save();
```

Note: for a freshly created content type the default `entity_form_display` may not exist yet — use
`\Drupal::service('entity_display.repository')->getFormDisplay(...)` (which creates it) rather than
loading it, or `setComponent()` will be called on `NULL`.

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_period
# look for: type: single_date_time_range_widget
```

## Requirements

Enable both `datetime_range` (provides the `daterange` field type) **and** the parent
`single_datetime` module (the widget class extends its base), and install the xdan
jQuery DateTimePicker library at `/libraries/jquery-datetimepicker`. There is no config schema, so
widget settings are stored as-is on the form-display component.
