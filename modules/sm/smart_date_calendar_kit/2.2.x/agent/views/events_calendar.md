# The Events Calendar view (`views.view.events_calendar`)

Imported once from `config/install/views.view.events_calendar.yml` — the module's entire surface.
Base table `node_field_data` (`base_field: nid`). It plots published `event` nodes on a
FullCalendar calendar. Edit at `admin/structure/views/view/events_calendar`.

## Displays

| Display | Type | Path / placement |
|---|---|---|
| default (Master) | — | title "Events Calendar" |
| `page_1` | page | `events/calendar`, menu **tab** "Calendar" (`main` menu) |

`page_1` is a `tab`, so it joins the local-task tab bar that Smart Date Starter Kit's
`events/upcoming` + `events/past` pages create (all under the main-menu "Events" set).

## Access, filters, pager, caching

- Access: `perm` → **`access content`** (standard published-node viewing).
- Filters: `status = 1` (published) and `type` restricted to the `event` bundle.
- No pager (`pager: none`, `items_per_page: 0`) — all matching events are loaded for the calendar.
- Cache plugin `tag`; invalidates on `config:field.storage.node.field_when`.

## Fields

Row style is `fields`. Two fields are defined — the FullCalendar style reads the date field to
place events; `title` supplies the event label/link:

| Field | Table | Formatter | Notes |
|---|---|---|---|
| `title` | `node_field_data` | `string`, `link_to_entity: true` | event title, links to the node |
| `field_when` | `node__field_when` | `smartdate_default` (`format: default`) | the Smart Date value; source for calendar placement |

## FullCalendar style (`style: fullcalendar`)

The `fullcalendar` Views style (from the `fullcalendar` module) turns the rows into a calendar.
Key options as shipped:

- **Views enabled**: month (`dayGridMonth`), week (`timeGridWeek`), day (`timeGridDay`), and list —
  `month_view` / `timegrid_view` / `daygrid_view` / `list_view` all true. `initialView: dayGridMonth`,
  `firstDay: '0'` (Sunday).
- **Date source**: `fields.date: true`, `date_field: field_when` — each event is plotted from its
  `field_when` Smart Date range (start → end).
- **Toolbar** (`header`): `left: 'dayGridMonth,timeGridWeek,timeGridDay'`, `center: 'title'`,
  `right: 'today prev,next'`.
- **Event colour**: `event_format.eventColor: '#3788d8'`, `eventDisplay: auto`.
- **Navigation / editing** (`links`): `navLinks: true` (click a day/week header to drill in),
  `bundle_type: event`, `updateConfirm: false`, `showMessages: true`. With the fullcalendar
  module's edit support and the appropriate node permissions, events can be **drag-and-drop
  rescheduled**, and double-clicking a slot opens an add form pre-filled with that time (that
  behaviour is provided by the `fullcalendar` module, not by this config).
- **Colour by bundle/taxonomy** (`colors`) is present but empty (single colour by default).
- **Google Calendar** feed fields (`google.googleCalendarApiKey` / `googleCalendarId`) are empty.
- Sub-settings include `month_view_settings.fixedWeekCount: true` / `showNonCurrentDates: '1'`,
  `timegrid_view_settings.allDaySlot: true`, and `list_view_settings.noEventsMessage: 'No events to display'`.

## Header — "Add an Event"

The default display has an `add_content_by_bundle` header handler (label **"Add an Event"**,
`bundle: event`, rendered as a `button`, width 600) from the `add_content_by_bundle` module. It
renders a node-add link for the `event` bundle; core still enforces node create access when the
link is followed.

## Dependencies

Config: `field.storage.node.field_when`, `node.type.event` (both installed by Smart Date Starter
Kit). Modules: `add_content_by_bundle`, `fullcalendar`, `node`, `smart_date`, `user`.

## Notes for changes

- **Empty calendar**: with no `event` nodes the calendar renders blank — create one at
  `/node/add/event` first, then visit `/events/calendar`.
- **Recurring events**: enable `smart_date_recur` and turn on recurring values on
  `node.event.field_when` at `admin/structure/types/manage/event/fields/node.event.field_when`;
  the view is already built to handle multi-value/recurring dates.
- **Colour / popup tweaks**: adjust the `fullcalendar` style options (e.g. `event_format.eventColor`,
  the `colors` map for per-bundle/taxonomy colours, or the link/popup behaviour) via the Views UI or
  `drush config:edit views.view.events_calendar`.
- **Who can see it**: change the `access` option away from `access content`, and/or the `status`
  filter, to expose unpublished or role-restricted events.
