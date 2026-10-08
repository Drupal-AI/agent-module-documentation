# Calendar Link — manual setup guide

**Calendar Link** (`calendar_link`) gives themers two Twig functions for building
"add to calendar" links — the buttons that let a visitor drop an event straight
into their own calendar in one click. You pass an event's details (title,
start/end dates, an all-day flag, a description, and a location) to a function in
your template, and it returns a ready-made URL for Google Calendar, Yahoo,
iCal/`.ics`, Outlook.com, or Office 365.

There are two functions. `calendar_link('google', ...)` returns a single URL for
one named provider, and `calendar_links(...)` returns an array of URLs keyed by
provider — handy for rendering a whole "add to calendar" menu at once. Because
the values come from your template, they normally map straight from a node's own
date and text fields, and Views support means the links can appear in listings
as well as on full content pages.

Everything happens server-side in Twig as plain URL construction — there are no
routes, no stored configuration, no external API calls, and no JavaScript.
Enabling the module is the entire setup; from there it is a theming task. Twig
auto-escapes the returned URLs (the functions do not mark their output as safe
HTML), so field values flow through Drupal's normal escaping.

This guide is written for a **human**, mostly a themer. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — and see
[`agent/api/twig.md`](../agent/api/twig.md) for the exact function signatures and
a template example.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives

Calendar Link has no admin UI and no settings. Once enabled, its two Twig
functions are available in any template.

## How to use it

In a template that renders an event, call the function with your event's fields.
For a single provider:

```twig
<a href="{{ calendar_link('google', label, node.field_start.date, node.field_end.date, false, body, location) }}">
  Add to Google Calendar
</a>
```

Or render links for every provider at once:

```twig
<ul class="add-to-calendar">
  {% for provider, url in calendar_links(label, node.field_start.date, node.field_end.date) %}
    <li><a href="{{ url }}">{{ provider }}</a></li>
  {% endfor %}
</ul>
```

The `from`/`to` arguments are PHP `DateTime` objects — on a datetime field,
`.date` gives you one. The main setup task is mapping your date field(s) to those
`DateTime` values and choosing which providers to render.
