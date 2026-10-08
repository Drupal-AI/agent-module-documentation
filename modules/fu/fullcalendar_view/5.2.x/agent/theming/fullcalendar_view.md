# Front-end library, AJAX route & theming

## The FullCalendar library

Defined in `fullcalendar_view.libraries.yml`. The feature library `fullcalendar_view/fullcalendar`
attaches `js/fullcalendar_view.js` and depends on `core/jquery`, `core/drupalSettings`,
`core/drupal.dialog.ajax`, and `fullcalendar_view/libraries.fullcalendar`, which in turn pulls in:

- `libraries.fullcalendar-theme` — FullCalendar CSS (v4.4.2)
- `libraries.fullcalendar` — FullCalendar core + daygrid/timegrid/list/interaction/moment/rrule JS
- `libraries.moment` (2.29.4), `libraries.rrule` (2.6.8), `libraries.jsframe` (1.5.16),
  `libraries.fullcalendar.google_calendar`

**CDN vs local:** `hook_library_info_alter` (`_fullcalendar_view_use_cdn` /
`_fullcalendar_view_use_cdn_full_path`) checks whether each local file exists under
`DRUPAL_ROOT/libraries/...`; if not, it swaps in the declared `cdn` URL. So libraries load from
CDN out of the box and are used locally only if you download them to `/libraries/...` (paths listed
in README).

The JS reads its behavior from `drupalSettings` keys the plugin sets, including `languageSelector`,
`updateConfirm`, `dialogWindow`, `eventBundleType`, `startField`, `endField`, `dblClickToCreate`,
`entityType`, `addForm`, `token` (CSRF), `openEntityInNewTab`, `calendar_options`, `dialog_options`.

## AJAX date-change route (drag-drop / resize)

`fullcalendar_view.routing.yml`:

| Route | Path | Controller | Permission |
|---|---|---|---|
| `fullcalendar_view.update_event` | `/fullcalendar-view-event-update` | `CalendarEventController::updateEvent` | `access content` |
| `fullcalendar_view.add_event` | `/fullcalendar-view-event-add` | `CalendarEventController::addEvent` | `access content` |

`updateEvent()` (POST) validates the `token` against `csrf_token` for the current user, reads
`eid`, `entity_type`, `start`, `end`, `start_field`, `end_field`, loads the entity, checks
`$entity->access('update')`, and writes the new start/end (datetime or daterange) back — this is how
a dragged/resized event is persisted. Access is gated by the per-entity update check, not a custom
permission.

`fullcalendar_view_form_node_form_alter` prepopulates a new node's start-date field from the `start`
query parameter when you double-click a slot to add an event.

## Theming

`hook_theme()` registers the `fullcalendar` theme hook (preprocess in
`fullcalendar_view.theme.inc`). The Views style declares theme `views_view_fullcalendar`; override
`templates/views-view-fullcalendar.html.twig` in your theme to change the calendar wrapper markup.
