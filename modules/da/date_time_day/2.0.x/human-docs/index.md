# Date time day — manual setup guide

**Date time day** (`date_time_day`) provides a field type that stores one date
together with a **start time and an end time on that same day** — the shape of
"Tuesday, 9:00 to 17:00" — all in a single field.

Core already gives you a datetime field and, through `datetime_range`, a range of
two full datetimes. Neither is quite right for something that happens within one
day. A range technically stores it, but as two independent datetimes: nothing
stops an editor entering an end date on a *different* day, the widget asks for the
date twice, and any "what is happening on this day" query has to reason about both
ends. Date time day encodes the constraint in the data itself — one date, one
start time, one end time — so the widget asks for the date once, validation is
meaningful, and a view filtered by date never has to handle a range straddling
midnight. It fits opening hours, class timetables, appointment slots, conference
sessions, and shift rotas.

Two things are worth settling before you choose it. First, **anything crossing
midnight does not fit** — an overnight shift or a session running to 01:00 needs
the core date-range field instead, and swapping field types once content exists is
expensive to reverse. Second, **timezones**: a time on a day is only unambiguous
once you know whose day it is, so on a site with an international audience confirm
how the field stores and renders the time before you commit to it.

The module works as soon as it is enabled — it adds a new field type you can
attach to any content type or other fieldable entity. It depends only on core's
**Datetime** module, and there is no separate settings page; you configure it per
field on the usual Field UI *Manage form display* and *Manage display* screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Once enabled, you add a
Date time day field to an entity and configure its widget and format on the
field's *Manage form display* / *Manage display* tabs, exactly as you would any
standard Drupal field.

## Where it lives in the admin menu

Date time day adds no admin page of its own. You use it from **Structure →
Content types → *(your type)* → Manage fields**, where you add a new field of type
**Date time day**, then set its input and output on the **Manage form display**
and **Manage display** tabs. See Drupal's Field UI help for the general
walkthrough of adding and displaying fields.
