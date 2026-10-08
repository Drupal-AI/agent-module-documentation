# Flexible Event Calendar API — manual setup guide

**Flexible Event Calendar API** (`flexible_event_calendar`) provides a Drupal
**render element** that turns event data into a calendar display, using the
[evo-calendar](https://github.com/edlynvillegas/evo-calendar) JavaScript library
that the module bundles. It is, as the name says, an **API** — a building block
for developers and site builders rather than a point-and-click feature.

There is **no settings form and no admin page**. Instead you feed the render
element an array of events (each with an id, name, date, and type) from your own
code — typically a custom block plugin — and the module renders them as a
calendar. This makes it a good fit when you want a calendar built from your own
event content and rendered exactly the way your code decides, rather than a
turnkey calendar view.

Because it renders whatever event data your code passes in, it has **no
access-control role** of its own — respecting event visibility is the
responsibility of the code that gathers the events and hands them to the element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you use it from code, as
shown in "How to use it" below.

## Where it lives in the admin menu

Nowhere — Flexible Event Calendar API adds no admin menu items and no settings
form. It is consumed programmatically through its render element.

## How to use it

The module expects a render array of type `flexible_event_calendar` with a
`#data` key holding your events. The usual place to build this is a **custom block
plugin**, whose `build()` returns something like:

```php
$build['flexible_event_calendar'] = [
  '#type' => 'flexible_event_calendar',
  '#data' => [
    'events' => [
      ['id' => '111', 'name' => 'New Year',            'date' => 'January/1/2020',  'type' => 'event'],
      ['id' => '222', 'name' => 'Board Meeting',        'date' => 'January/31/2020', 'type' => 'event'],
    ],
  ],
];
```

To customise the calendar's JavaScript behaviour, you can override the bundled
`evo-calendar.custom.js`: place your own copy in a custom module's `js/` folder,
declare it in that module's `*.libraries.yml` with a dependency on
`flexible_event_calendar/flexible_event_calendar_js`, and attach it to the render
element:

```php
$build['flexible_event_calendar'] = [
  '#type' => 'flexible_event_calendar',
  '#data' => ['events' => [ /* … */ ]],
  '#attached' => [
    'library' => ['custom_module_name/custom_library_name'],
  ],
];
```

Populate the `events` array from wherever your events live — for example a query
over an "Event" content type — and the element renders them into the calendar.
