# FullCalendar Block — manual setup guide

**FullCalendar Block** (`fullcalendar_block`) gives you a placeable block that renders
a calendar — powered by the popular FullCalendar 5 JavaScript library — from a JSON
feed of events. You point the block at a URL that returns events (most commonly a
Drupal View's REST export, but any custom controller or external event API works
too), and it draws a month/week/day calendar wherever you place the block.

There is no separate admin settings page. Instead you place the **FullCalendar block**
through Drupal's normal Block layout and configure it on the block's own form: the
event-feed URL, the starting view, the header toolbar, what happens when a visitor
clicks an event, and a couple of advanced options for power users. Each block instance
keeps its own settings, so you can put several independent calendars on one page.

The module works once enabled and a block is placed, but it needs the FullCalendar
JavaScript library to be available — it loads it locally from `/libraries/…` if
present, and otherwise falls back to a CDN copy. It depends on core's **Block** and
**Datetime** modules, is licensed MIT, and provides no permissions, Drush commands, or
plugin types. Developers can adjust a calendar's options from another module via a PHP
alter hook, and react to the calendar in the browser via JavaScript events.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and make the FullCalendar library available.

## Where it lives in the admin menu

There is no dedicated settings page. You place the block from **Structure → Block
layout** (`/admin/structure/block`) with **Place block**, searching for *FullCalendar
block*, and all of its options are on that block's configuration form.

## How to use it

### 1. Prepare an event feed

The calendar reads events from a JSON URL. The typical approach is a **View** with a
**REST export** display that outputs events in FullCalendar's expected shape, reachable
at a path like `/event-feed`. You can also use an absolute URL to an external event
API. To load events lazily as the visitor navigates months, expose start/end date
filters on the source View so the calendar can fetch just the visible range.

### 2. Place and configure the block

Go to **Structure → Block layout**, click **Place block** in the region you want, and
choose **FullCalendar block**. On the block form the main settings are:

- **Event source** *(required)* — the JSON feed URL, relative (e.g. `/event-feed`) or
  absolute.
- **Use token replacement** — enable to substitute tokens (such as the current node
  ID) into the event-source URL. The Token module gives you a token picker.
- **Initial view** — the view the calendar opens on; defaults to `dayGridMonth`
  (month grid). Other options include `timeGridWeek`, `timeGridDay`, and `listMonth`.
- **Header toolbar (start / center / end)** — the three segments of the top toolbar,
  controlling the prev/next/today buttons, the title, and the view switcher.
- **Event click behaviour** — open a clicked event in a **modal dialog** (the
  default), a **new tab**, or the **current tab**; plus a **dialog width** when using
  the dialog.
- **Plugins** — optionally enable the `moment` plugin (extra locales/date handling)
  and/or the `rrule` plugin (recurring events).
- **Advanced** and **Advanced (Drupal)** — two free-form YAML/JSON boxes for power
  users. *Advanced* accepts any raw FullCalendar option (for example
  `initialDate: '2022-05-01'`); *Advanced (Drupal)* controls extras like description
  popups, draggable/resizable events, and colour-coding events by field.

Save the block. The calendar renders in that region, pulling firstDay, text
direction, and locale from your Drupal settings automatically.

### 3. Place more than one

Because settings live on each block instance, you can place several FullCalendar
blocks — each with its own feed and options — on the same or different pages.

## For developers

Another module can alter a block's calendar options with
`hook_fullcalendar_block_settings_alter()` (for example to add a second event source
or enable description popups), and browser code can listen for the
`fullcalendar_block.beforebuild` and `fullcalendar_block.build` JavaScript events to
post-process the calendar. See the sibling [`agent/`](../agent/start.md) docs for
details.
