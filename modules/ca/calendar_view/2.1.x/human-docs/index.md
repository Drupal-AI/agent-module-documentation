# Calendar View — manual setup guide

**Calendar View** (`calendar_view`) adds two Views display styles — **Calendar by
month** and **Calendar by week** — that render a View's results as an HTML‑table
calendar, placing each row on the day of a date field you choose. It is a lightweight,
Views‑native way to put any date‑bearing content on a calendar without a third‑party
JavaScript library.

You build it like any other View: create a View of your content (or any entity), add at
least one supported **Date field** to the View's fields, set the display's Format to
*Calendar by month* (or week), and tick that date field in the style's settings.
Supported field types include `date`, `created`, `changed`, `datetime`, `daterange`,
`smartdate`, and `timestamp`, so you can drive a calendar off authored dates,
last‑changed dates, a scheduled publish date, or a custom event date.

The module also ships matching **pager** plugins for previous/next month or week
navigation, a **"Jump to"** exposed filter so visitors can navigate to any date (also
via a `?calendar_timestamp=` URL), and options for the first weekday, default date, sort
order within a day, and a token‑driven calendar caption. The results render into a plain,
themeable `<table>` with useful CSS classes on each cell (today, past, future, has
results), so you can style it however you like.

There is **no global settings page** — everything is configured per display in the Views
UI. This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the plugin ids and every option —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and optionally enable the multi‑day submodule.
2. [Configuration](configuration/index.md) — building a calendar View step by step, the
   style options, and the pager and "Jump to" filter.

## Where it lives in the admin menu

Calendar View adds no configuration page of its own. You use it entirely inside the
Views UI at **Structure → Views** (`/admin/structure/views`) — by choosing the
*Calendar by month* or *Calendar by week* format on a View display.
