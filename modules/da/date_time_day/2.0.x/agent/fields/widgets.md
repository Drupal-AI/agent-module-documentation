# Widgets (input on Manage form display)

Two field widgets, both for field type `datetimeday`, both extending the shared base
`src/Plugin/Field/FieldWidget/DateTimeDayWidgetBase.php` (which itself extends core
`DateTimeWidgetBase`). Choose one on the entity/bundle's **Manage form display** tab.

| Widget id | Class | Label | Start/end input |
|---|---|---|---|
| `datetimeday_default` | `DateTimeDayDefaultWidget` | Date time day | Plain `textfield`s, `H:i`, HTML `pattern` `([01]?[0-9]{2}|2[0-3]):[0-5][0-9]`, title `hh:mm` |
| `datetimeday_h_i_s_time` | `DateTimeDaySecondsWidget` | Date time day with seconds | HTML `time` elements (`#date_time_element = 'time'`), `H:i:s` |

Both render three sub-elements wrapped in a `fieldset`: `value` (the day, an HTML `date` element),
`start_time_value` and `end_time_value`. Use `datetimeday_h_i_s_time` together with the storage
`time_type = time_seconds`; use `datetimeday_default` with `time_type = time`.

Set the widget from code:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'event', 'default')
  ->setComponent('field_hours', ['type' => 'datetimeday_h_i_s_time'])
  ->save();
```

## Base behaviour (`DateTimeDayWidgetBase`)

- `formElement()` builds the day element (core datetime widget), then clones it into
  `start_time_value` / `end_time_value`, seeds `#default_value` from the computed `date`, `start_time`,
  `end_time` properties, and appends the `validateStartEnd` element validator.
- `massageFormValues()` converts each submitted `DrupalDateTime` back to storage: the day → `Y-m-d`
  (`DATE_STORAGE_FORMAT`), and start/end → `H:i` or `H:i:s` depending on the field's `time_type`; each is
  first shifted to the storage timezone (`DateTimeItemInterface::STORAGE_TIMEZONE`, UTC).
- `validateStartEnd()` — the only business rule: if both times are present it builds `DrupalDateTime`
  objects (padding a 5-char value to `:00` under `time_seconds`) and, when they differ, sets a form error
  ("The @title end date cannot be before the start date") if `start` is after `end` (`$interval->invert === 1`).
  There is no cross-field check that the day itself is consistent — only start ≤ end.

Note: `DateTimeDayWidgetBase` is a concrete class but has no `@FieldWidget` annotation, so it is not a
selectable widget on its own — only the two subclasses above appear in Field UI.
