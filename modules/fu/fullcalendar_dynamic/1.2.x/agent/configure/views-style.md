# Fullcalendar Dynamic — Views setup & style options

There is no admin settings page. You configure everything on a View.

## Build a calendar View
1. Create a View of an entity that has a date/datetime field (add the date field, plus title/link
   fields you want).
2. Add a display and set its **Format / Style** to **FullCalendar Display** (style id
   `fullcalendar_dynamic`), or use the **FullCalendar Page** display (id `fullcalendar_dynamic`,
   title "FullCalendar Page") which pre-selects that style, drops the pager, and exposes a page
   URL + menu link (it extends the core Page display; `getType()` = `fullcalendar`).
3. In the style settings, map View fields to calendar roles (below) and Save.

## Style options (`FullCalendar::defineOptions()`)
Key options stored under the display's `style.options`:

| Option | Purpose |
|---|---|
| `start` | View field holding the event start date (required). |
| `end` | View field holding the event end date. |
| `title` | View field used as the event title/label. |
| `duration` | Field expressing event duration. |
| `rrule` | Field holding an iCal RRULE string for recurring events (rendered read-only). |
| `date_filter` | The View field whose datetime filter is narrowed to the visible calendar window on AJAX navigation (see the event-source controller). |
| `default_date_source` | `now` (default) or a fixed date source. |
| `defaultDate` | Explicit initial date the calendar opens on. |
| `tooltip_content` / `tooltip_title` | Fields used for the event tooltip body/title. |
| `tooltip_theme` | tippy.js theme (light / light-border / material / translucent). |
| `right_buttons` | Toolbar view buttons; default `['dayGridMonth','timeGridWeek','timeGridDay','listYear']`. |
| `bundle_type` | Entity bundle used for taxonomy-color resolution. |
| `tax_field` | The taxonomy reference field driving per-event color. |
| `vocabularies` | Vocabulary used for the color map. |
| `color_bundle` | Map of bundle → color. |
| `color_taxonomies` | Map of term → color. |

The style sets `$usesFields = TRUE` (you add fields and reference them by machine name in the options
above). Taxonomy colors are resolved by the `fullcalendar_dynamic.taxonomy_color` service; datetimes are
timezone-converted by `fullcalendar_dynamic.timezone_conversion_service`.

## Rendering pipeline
- `template_preprocess_views_view_fullcalendar_enanced()` (in `fullcalendar_dynamic.theme.inc`) and the
  `fullcalendar_dynamic.view_preprocess` service (`FullcalendarViewPreprocess`) build the event array
  and push calendar config to `drupalSettings.fullCalendarView[<view_index>]` (including
  `tooltip_theme` when set).
- `js/fullcalendar_view.js` (library `fullcalendar_dynamic/fullcalendar`, deps `core/jquery`,
  `core/drupalSettings`, `core/drupal.dialog.ajax`, the FullCalendar bundle) instantiates the calendar.
- As the user pages to another month/week, the calendar POSTs to `/fullcalendar-view/events` to reload
  events for that window (see [../plugins/processor.md](../plugins/processor.md)).

## Libraries (local vs CDN)
`fullcalendar_dynamic.libraries.yml` expects the JS libs under the site's `/libraries/` dir
(FullCalendar core+plugins, moment, rrule, JSFrame, popperjs, tippy.js themes). `hook_library_info_alter`
(`fullcalendar_dynamic_library_info_alter`) can swap moment/rrule/jsframe to their CDN URLs via
`_fullcalendar_dynamic_use_cdn_full_path()` when a local copy is absent.
