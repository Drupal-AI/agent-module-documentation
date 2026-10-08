# Configuration

FullCalendar has no admin settings page — you configure each calendar **inside a
View**. This page walks through attaching the style and the main option groups you
can set on it. All the settings are stored on the View itself.

## Attach the FullCalendar style to a View

1. Create or edit a View whose rows are date-bearing entities (for example event
   nodes with a datetime or date-range field). Use a **Fields** row style and
   include the date field(s) you want plotted.
2. In the View's **Format** section, change the style to **FullCalendar**.
3. Open the FullCalendar settings and, at minimum, map the **Date** field, then
   choose which calendar views to enable (month / time-grid / day-grid / list).
4. *(Optional)* Under the View's **Advanced → Use AJAX** setting, turn AJAX on so
   navigating between months/weeks fetches events without a full page reload.

Filters, contextual filters and sorts all work as usual, so you can, for example,
show only published events, or scope the calendar to one taxonomy term.

## The main option groups

The FullCalendar style exposes a lot of options; the ones you'll reach for most:

- **Fields** — map which View fields provide each event's **title**, **URL**
  (link), and **start/end date(s)**. The date mapping is required; a date-range
  field lets multi-day events span the correct days.
- **Enabled views** — toggle **month**, **time-grid** (week/day), **day-grid**,
  and **list** views. The visitor can switch between the ones you enable.
- **Display** — the **initial view** shown on load (e.g. month) and the **first
  day of the week**.
- **Header / footer toolbars** — the prev/next/today buttons and view-switch
  buttons across the top and/or bottom, plus title formatting and the range
  separator.
- **Event format** — default event color, how events display, whether to show
  event times, and the "next day" threshold for multi-day events.
- **Colors** — color-code events **by content type (bundle)** and/or **by a
  taxonomy term** reference, each with a color and text color. These feed the
  optional `fullcalendar_legend` submodule.
- **Interactivity (links)** — **navLinks** (click a day or week to jump to its
  view), **click-to-create** (double-click a day to create a new event of a
  chosen bundle, in a chosen form mode and modal width), and **drag-and-drop
  update** with an optional confirmation before the change is saved.
- **Times / axis** — timezone conversion, which weekends/days to show, day
  headers, and the time-axis controls (slot duration — default 30 minutes — slot
  label interval and format, and the min/max/scroll times).
- **Week / now / business hours** — show week numbers, a "now" indicator line, and
  restrict/emphasise business hours.
- **Style** — theme system, height, aspect ratio, and window-resize behaviour.
- **Google Calendar** — pull in a Google Calendar feed by supplying a Google
  Calendar **API key** and **calendar id**.

Set what you need and save the View. A View whose style is FullCalendar renders as
a calendar wherever you place its page, block or attachment.

## Interactivity and permissions

Drag-and-drop rescheduling and click-to-create work through AJAX routes that
require the core **Access content** permission (so anonymous visitors can view and
navigate the calendar). To let trusted users **move any event** regardless of
normal entity edit access, grant them the **Update any FullCalendar event**
permission (`update any fullcalendar event`) on the *People → Permissions* page:

```bash
drush role:perm:add editor 'update any fullcalendar event'
```

Without that permission, whether a given user can drag an event is governed by
normal entity-edit access.

## Checking the result

You can inspect a View's stored FullCalendar settings from the command line:

```bash
drush config:get views.view.<your_view>
# look under display.default.display_options.style — type: fullcalendar
```

The `style.type` value of `fullcalendar` is what marks a display as a FullCalendar
calendar.
