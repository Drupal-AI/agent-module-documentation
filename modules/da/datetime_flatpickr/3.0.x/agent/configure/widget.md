<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Flatpickr widgets

No global settings page (`configure` null). You choose a Flatpickr widget on an entity's **Manage form
display** tab (`admin/structure/…/form-display`) for a Date/time or Date-range field, then open the
widget cog to set its options. Settings persist in the `entity_form_display` config entity.

## The three widgets

| Widget id | For field type | Notes |
|---|---|---|
| `datetime_flatpickr` | `datetime` | Single date (and optional time) picker. |
| `datetime_range_flatpickr` | `daterange` | Range picker in one input. |
| `datetime_range_separate_inputs_flatpickr` | `daterange` | Range with separate start/end inputs. |

All extend core `DateTimeWidgetBase` and share the settings via `DateTimeFlatPickrWidgetTrait`.

## Where settings are stored

```
core.entity_form_display.<entity>.<bundle>.<form_mode>:
  content:
    <field_name>:
      type: datetime_flatpickr        # or datetime_range_flatpickr / *_separate_inputs_flatpickr
      settings: { …see keys below… }  # schema: datetime_flatpickr_config
```

## Settings keys (defaults from `getDefaultSettings()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `dateFormat` | string | `Y-m-d H:i` | Machine format handled in the input (PHP tokens; `s`→seconds handled specially). |
| `altInput` | bool | `false` | Show a friendly display value while submitting `dateFormat` to the server. |
| `altFormat` | string | `F j, Y` | Display format used when `altInput` is on. |
| `use_system_format` | bool | `false` | Use a Regional-settings date format for the alt display (needs `altInput`). |
| `system_date_format` | string | `''` | Which `date_format` entity to use when `use_system_format`. |
| `allowInput` | bool | `false` | Allow typing directly into the field. |
| `enableTime` | bool | `false` | Show the time picker. |
| `enableSeconds` | bool | `false` | Include seconds in the time picker. |
| `time_24hr` | bool | `false` | 24-hour time, no AM/PM. |
| `minDate` / `maxDate` | string | `''` | Inclusive selectable-date bounds. |
| `minTime` / `maxTime` | map `{hour,min}` | empty | Inclusive selectable-time bounds (hour 0–23, min 0–59). |
| `minuteIncrement` | int | `5` | Minute step. |
| `position` | string | `auto` | Calendar position: `auto`/`above`/`below`. |
| `weekNumbers` | bool | `false` | Show ISO week numbers. |
| `disabledWeekDays` | array | `[]` | Weekday indexes to disable (checkboxes). |
| `disabledDates` | string/array | `[]` | Dates to disable, one `YYYY-MM-DD` per line (validated). |
| `inline` | bool | `false` | Render the calendar inline (always visible). |
| `mode` | string | `single` | `single` / `multiple` / `range`. |
| `jumpToDate` | string | `''` | Month/date the calendar opens on. |
| `defaultDate`/`defaultHour`/`defaultMinute` | string | `''` | Initial values. |

Settings are sanitized with `Html::escape` on string values before being emitted to the browser, and
PHP date tokens are mapped to flatpickr tokens (`convertPhpToFlatpickrFormat`) when `use_system_format`
is used. On save, `massageFormValues()` parses the input with `dateFormat` and converts to Drupal's
storage format/timezone (`DATE_STORAGE_FORMAT` for date-only, `DATETIME_STORAGE_FORMAT` otherwise).

## Set a widget with Drush (example)

```php
// drush php:eval — put the flatpickr widget on node.article field_event with time + 15-min steps
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_event', [
  'type' => 'datetime_flatpickr',
  'region' => 'content',
  'settings' => ['dateFormat' => 'Y-m-d H:i', 'enableTime' => TRUE, 'time_24hr' => TRUE, 'minuteIncrement' => 15],
])->save();
```

## Library loading (CDN vs self-hosted)

- Asset library `datetime_flatpickr/flatpickr` references flatpickr **4.6.11 from cdnjs (cloudflare)**;
  `datetime_flatpickr/flatpickr-init` adds `js/datetime-flatpickr.js` + `css/datetime-flatpickr.css`.
- `hook_library_info_alter` (`_datetime_flatpickr_get_flatpickr_path()`) swaps the CDN URLs for a local
  copy if `libraries/flatpickr/dist/flatpickr.js` exists (in the site/profile/site-specific `libraries/`).
  Self-host to avoid the external CDN dependency.
- The matching flatpickr **locale** library (`flatpickr_<lang>`) auto-loads based on the current
  interface language (see `Constants/AvailableLanguages`).
