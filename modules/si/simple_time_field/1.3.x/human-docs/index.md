# Simple Time Field — manual setup guide

**Simple Time Field** (`simple_time_field`) gives you a dedicated time-of-day
field type for any Drupal entity — the hours and minutes, without a date attached.
It is the field you reach for when you want to store an opening time, a class
start, a delivery window or a broadcast slot, and the calendar date is simply
irrelevant.

Drupal core's datetime field always carries a date, so storing "09:00" means
inventing a date to hang it on — which then leaks into your displays, your sorting
and your timezone handling in ways nobody wants. Simple Time Field sidesteps all of
that by storing a plain time value (HH:MM, or HH:MM:SS when you turn on seconds). It
uses the browser's native HTML5 time input, supports minimum/maximum limits and
configurable step intervals from one second up to one hour, and ships four
formatters — including a configurable one that accepts a custom PHP date format and
a display-only timezone shift. It also registers a Feeds import target that parses
human-readable strings like "2:30 PM" into a clean stored value, and because values
are stored as text they sort and filter reliably in Views.

The module works entirely through Drupal's standard Field UI — there is no separate
settings page. Everything you configure happens on the field itself when you add it
and set up its form and display. It depends only on core's **Field** module.

One thing worth keeping in mind: a time without a date has no single unambiguous
instant, so the display-timezone option matters and comparing times across zones is
not really meaningful. For genuine opening-hours modelling with holidays and
exceptions, a dedicated module such as Office Hours is a better fit. Simple Time
Field is the right tool when a plain time value is what you actually need.

This guide is written for a **human** setting the field up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Because this is a field type, you use it wherever Drupal lets you add fields:

1. Go to **Structure → [your entity type] → Manage fields** and add a new field of
   type **Time**.
2. In the field's **storage settings**, choose whether to include seconds.
3. On **Manage form display**, click the field's gear icon to set a minimum and
   maximum time and the time interval (step).
4. On **Manage display**, pick a formatter — for example 12-hour AM/PM or 24-hour —
   and, with the configurable formatter, an optional display timezone offset.

If the **Feeds** module is enabled, Simple Time Field also provides a smart import
mapper that normalises messy strings such as "2pm" or "14:30" during imports without
any manual pre-processing.
