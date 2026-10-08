# Configure the Full Calendar Display

There is **no global settings form and no `configure` route** — the module is configured
entirely inside a View. Settings are stored in the View's style options
(`views.style.fullcalendar_view_display` schema in `config/schema/`).

## Set up a calendar View

1. Structure → Views → add a View of the content you want (or edit an existing one).
2. Add **Fields** including at least a start-date field, a title field, and optionally an
   end-date field, an RRULE field, and a duration field.
3. Set **Format** to **Full Calendar Display**, then open its **Settings**.
4. Map fields and options (below), save.

The style plugin is `id = fullcalendar_view_display` (`FullCalendarDisplay`,
`usesFields = TRUE`, theme `views_view_fullcalendar`).

## Key style options (defaults from `defineOptions()`)

| Option | Default | Purpose |
|---|---|---|
| `start` | `''` | View field used as the event **start date** (required) |
| `end` | `''` | View field used as the event **end date** (optional) |
| `title` | `''` | View field used as the event title |
| `rrule` | `''` | Field holding an RRULE string for recurring events |
| `duration` | `''` | Field giving each recurring instance's length (e.g. `05:00`) |
| `default_date_source` | `now` | Initial date: `now`, `first` (first result), or `fixed` |
| `defaultDate` | `''` | Fixed initial date when source is `fixed` |
| `default_view` | `dayGridMonth` | Initial view mode |
| `default_mobile_view` | `listYear` | Initial view on mobile |
| `mobile_width` | `768` | Px width below which the mobile view applies |
| `right_buttons` | `[dayGridMonth, timeGridWeek, timeGridDay, listYear]` | View-switch buttons |
| `left_buttons` | `prev,next today` | Left header buttons |
| `firstDay` | (schema) | First day of week |
| `nav_links` | `1` | Day/week names link to those views |
| `timeFormat` | `hh:mm a` | Event time display format |
| `eventLimit` | `2` | Max events shown per day before "more" |
| `slotDuration` | `00:30:00` | Time-grid slot size |
| `minTime` / `maxTime` | `00:00:00` / `23:59:59` | Visible time window in week/day |
| `allowEventOverlap` | `1` | Allow events to overlap |
| `updateAllowed` | `1` | Enable drag-drop / resize rescheduling |
| `updateConfirm` | `1` | Confirmation dialog before saving a drag change |
| `createEventLink` | `0` | Double-click empty slot to create an event |
| `dialogWindow` | `0` | Open event links in a dialog window |
| `dialogModal` / `dialogCanvas` | `FALSE` | Modal popup / off-canvas editing |
| `openEntityInNewTab` | `1` | Open event entity in a new tab |
| `defaultLanguage` | `en` | Calendar locale |
| `languageSelector` | `0` | Show a runtime language selector |
| `bundle_type` | `''` | Bundle used for new events created on the calendar |

## Event colors

- `tax_field` + `vocabularies` + `color_taxonomies` — color events by a taxonomy term field
  (backed by the `fullcalendar_view.taxonomy_color` service).
- `color_bundle` — a per-bundle color map (sequence in schema) to color by content type.

## Recurring events

Provide a plain-text field containing an RRULE, e.g.
`DTSTART:20200302T100000Z EXDATE:20200309T100000Z RRULE:FREQ=WEEKLY;UNTIL=20200331T120000Z;BYDAY=MO,WE`,
and select it as the **RRule field** under the style Settings. The optional duration field sets
each instance's end time.

## Google Calendar holidays

`fetchGoogleHolidays` + `googleHolidaysSettings` (`googleCalendarAPIKey`,
`googleCalendarGroup`, `renderGoogleHolidaysAsBackground`) overlay public holidays.
