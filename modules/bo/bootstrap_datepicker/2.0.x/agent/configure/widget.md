<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Bootstrap Datepicker widget

No settings page (`configure: null`). You select the widget per field on the entity bundle's
*Manage form display* page, or set it directly in the `entity_form_display` config.

## Requirements

- The field must be a core **`datetime`** field (the widget declares `field_types = {datetime}`).
- The JS/CSS library must be installed at `/libraries/bootstrap-datepicker` (from
  https://github.com/uxsolutions/bootstrap-datepicker). Without it the field still saves but the
  calendar popup does not render. The widget attaches libraries `bootstrap_datepicker/datepicker`
  and `bootstrap_datepicker/datepicker_<language>`.

## Where settings are stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`

```yaml
content:
  <field_name>:
    type: bootstrap_date_widget
    settings:
      format: 'dd/mm/yyyy'
      language: 'en'
      week_start: '1'
      autoclose: true
      # ... any of the option keys below
    third_party_settings: {  }
```

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. On the datetime field's row, choose **Bootstrap Datepicker** in the *Widget* select.
3. Click the cog to open the settings and set format, language, week start, autoclose, etc.
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_event_date', [
  'type' => 'bootstrap_date_widget',
  'weight' => 0,
  'region' => 'content',
  'settings' => ['format' => 'dd/mm/yyyy', 'autoclose' => TRUE, 'week_start' => '1'],
])->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_event_date
# type: bootstrap_date_widget ; settings.format: dd/mm/yyyy ; settings.autoclose: true
```

## Key option keys (from `defaultSettings()`)

Common: `format` (e.g. `dd/mm/yyyy`), `language` (IETF tag, default `en`), `week_start`
(0=Sunday…6), `start_view` (0 days…4 centuries), `min_view_mode`/`max_view_mode`,
`today_btn` (`FALSE`/`TRUE`/`linked`), `today_highlight`, `autoclose`, `clear_btn`,
`calendar_weeks`, `show_week_days`, `rtl`, `orientation`, `z_index_offset` (default 10).

Date bounds: `start_date_selection`/`end_date_selection` (`date` or `timedelta`), with
`start_date`/`end_date` (absolute, default `01-01-1000` / `31-12-2999`) or
`start_date_timedelta`/`end_date_timedelta` (e.g. `-1d`, `+6m +1y`).

Restrictions: `days_of_week_disabled` / `days_of_week_highlighted` (checkbox sets keyed 1–7),
`dates_disabled` (newline-separated), `disable_touch_keyboard`, `enable_on_readonly`,
`assume_nearby_year`, `force_parse`, `keyboard_navigation`, `immediate_updates`,
`keep_empty_values`, `update_view_date`, `container` (default `body`).

Note: some options (`toggle_active`, `multidate`, `multidate_separator`) are present but
disabled in the settings form ("Will be enabled for coming features").

## How settings reach the browser

The `bootstrap_datepicker` render element's process callback emits each setting that **differs
from the library default** as a `data-date-<option>` attribute (booleans as `true`/`false`),
plus `data-provide="datepicker"`, and attaches the JS library. So only non-default settings are
serialized into the DOM.
