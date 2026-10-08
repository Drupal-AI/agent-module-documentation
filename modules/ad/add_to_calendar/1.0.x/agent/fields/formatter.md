<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Add to calendar" formatter, field type & computed field

## The pieces

- **Field type** `add_to_calendar` — `src/Plugin/Field/FieldType/AddToCalendarItem.php`.
  One `value` column, `varchar(255)`, nullable; `isEmpty()` is true for `NULL`/`''`.
  `category = "General"`, `default_widget = "string_textfield"`,
  `default_formatter = "add_to_calendar_default"`. In practice you do not create this field by
  hand — the module injects it as a **computed base field** (see
  [../config/settings.md](../config/settings.md)); the field type mainly exists to bind the
  formatter.
- **Computed item list** `AddToCalendarItemList` (`src/AddToCalendarItemList.php`) —
  `computeValue()` sets `list[0]` to the placeholder string "Add to calendar". No storage.
- **Formatter** `AddToCalendarFormatter` (id **`add_to_calendar_default`**, label *"Add to
  calendar"*) — `src/Plugin/Field/FieldFormatter/AddToCalendarFormatter.php`, extends
  `FormatterBase`, injects `entity_field.manager` and `datetime.time`.

## Formatter settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `date_field` | `''` | Machine name of a **daterange** field on the bundle (its `value` = start, `end_value` = end). Required — no field, no output. |
| `description_field` | `''` | Optional field (`string`, `string_long`, `text`, `text_long`, `text_with_summary`) whose `value` becomes the event description. |
| `address_field` | `''` | Optional field (`string`, `string_long`) whose `value` (run through `strip_tags`) becomes the event location. |
| `enabled_generators` | `[]` | Checkboxes of which providers to render (see below). |

`settingsForm()` populates the three selects with `getFieldOptions()`, which filters
`entityFieldManager->getFieldDefinitions($entity_type, $bundle)` by field type. `settingsSummary()`
prints the chosen fields and generators on the Manage-display row.

### Available generators (`calendarPlugins()`)

`google` (Google Calendar), `ics` (iCalendar), `webOffice` (Office Calendar),
`webOutlook` (Outlook Calendar), `yahoo` (Yahoo Calendar). Each maps to a method of the Spatie
`Link` object.

## How `viewElements()` builds the links

1. Reads `date_field` + `array_filter(enabled_generators)`; returns empty if either is unset.
2. Gets the host entity; returns empty if it lacks the date field or the date field is empty.
3. **Future-only gate:** builds `DrupalDateTime` from `end_value` and returns nothing when
   `datetime.time` current timestamp is past the end — so the element shows only for upcoming
   events.
4. Resolves optional `description` (trimmed) and `address` (`strip_tags` + trim).
5. Per item × per enabled generator, creates
   `Spatie\CalendarLinks\Link::create($entity->label(), <start DateTime>, <end DateTime>)` from the
   daterange `value`/`end_value` parsed with `DateTimeItemInterface::DATETIME_STORAGE_FORMAT`,
   then `->description(...)` / `->address(...)` when present.
6. Emits a render element:

   ```php
   '#type' => 'html_tag', '#tag' => 'a',
   '#value' => $all_generators[$generator],           // translated label (safe markup)
   '#attributes' => [
     'class' => ["$generator-calendar-link"],
     'href'  => $link->{$generator}(),                // library-generated URL / data URI
     'title' => $all_generators[$generator],
   ],
   ```

   All attribute values pass through core's `HtmlTag` renderer, which escapes them. Any exception
   from the library is caught and logged to the `add_to_calendar` logger channel (via
   `Error::logException` / `watchdog_exception` compat shim). The `ics` link is a self-contained
   base64 `data:` URI — there is no server download route.
7. Attaches library `add_to_calendar/field`.

## Theming

- Theme hook **`field__add_to_calendar`** (registered in `add_to_calendar_theme()`), template
  `templates/field--add-to-calendar.html.twig`. It wraps the links in
  `.add-to-calendar--wrapper.hover`, renders a Font Awesome calendar icon + the label, and lists
  each generator link in a `<ul class="add-to-calendar--items">`.
- Library `add_to_calendar/field` = `css/add_to_calendar.css` + `js/add_to_calendar.js`
  (`Drupal.behaviors.addToCalendarField`: toggles hover on `touchstart`/`touchend` for touch
  devices) + deps `core/jquery`, `core/drupal`.

## Enabling on a display (config)

```yaml
# core.entity_view_display.node.event.default
content:
  add_to_calendar:
    type: add_to_calendar_default
    label: hidden
    settings:
      date_field: field_event_date        # a daterange field
      description_field: body
      address_field: field_location
      enabled_generators:
        google: google
        ics: ics
        webOutlook: webOutlook
```

Then `drush cr`. Remember the field only exists after the entity type is enabled at the settings
form (see [../config/settings.md](../config/settings.md)).

## Gotchas

- The date field **must be a daterange** with both start and end values; the future-only check and
  the `Link::create()` call both read `end_value`.
- Links render only while `end_value` is in the future — past events show nothing by design.
- The field type stores a `varchar(255)` column, but the shipped usage is computed (no stored
  value); `generateSampleValue()` exists only for test content.
