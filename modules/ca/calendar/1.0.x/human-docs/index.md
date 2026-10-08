# Calendar — manual setup guide

**Calendar** (`calendar`) displays Views results that contain a date field as a
**month, week, day, or year calendar**. If you have content with dates — events,
deadlines, publications — Calendar lays those results out in a familiar calendar
grid instead of a plain list, with pagers to move forward and back through time
and color-coded items.

Calendar works entirely through Drupal's **Views** system. It adds a Views
*style* plugin that draws the grid, a *row* plugin that places each result as a
calendar item (with legend colors), a *pager* plugin that steps through periods,
a header *area* handler that prints the current period's title, and the date
*arguments* (contextual filters) that decide which period is shown. The period
being displayed is driven by the URL (for example `/calendar/2026-07`), and a
bundled submodule (`calendar_datetime`) can open the calendar on today's date by
default.

The fastest way to build one is the **"Add from template"** link on the Views
listing page: pick your date field and Calendar generates a complete view with
Month, Week, Day, and Year page displays already wired up. Presentation is fully
theme-driven — the module ships Twig templates and CSS for every period type,
including handling of multi-day and overlapping events, a compact "mini" month,
and a legend block. Calendar is a **beta** release, and because calendars are
expensive to render, enabling Views caching is recommended.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full plugin
option list and theme-hook table — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its submodule, and the optional recurring-date add-on.

There is no dedicated configuration page in this guide: Calendar has no real
settings form (only a one-toggle admin form, covered below), because a calendar
is built as a **Views display**. See **How to use it** below.

## Where it lives in the admin menu

Calendars themselves are **Views**, built and managed at **Structure → Views**
(`/admin/structure/views`). The module also adds a tiny settings form at
**Configuration → Regional and language → Calendar**
(`/admin/config/date/calendar`, requires the *Administer calendar settings*
permission) — but it only toggles whether a user's chosen date is remembered in
their session when they switch between day/week/month/year. All real setup happens
in the Views UI.

## How to use it

### The fastest path — Add from template

1. Go to **Structure → Views**.
2. Click the **"Add from template"** link (provided by the required Views
   Templates module).
3. Choose the **date field** you want the calendar to run on.
4. Calendar generates a full view for you — a Master display plus **Month**,
   **Week**, **Day**, and **Year** page displays at `/month`, `/week`, `/day`, and
   `/year`, each shown as a menu tab, with the style, row, pager, header, and date
   arguments already configured.

### Building or tuning a calendar by hand

If you'd rather build or adjust a view yourself, the pieces are:

- **Style: Calendar** — the grid layout. Its main option is the calendar type
  (month / week / day / year), plus options for a mini calendar, week numbers, a
  cap on items per day, time-slot grouping for schedule-style day/week views, and
  overlap handling.
- **Row: Calendar entities** — places each result as an item and sets the legend
  colors (per content type, or per taxonomy term/vocabulary with a stripe
  legend).
- **Pager: Calendar Pager** — previous/next navigation through the current
  period.
- **Header: Calendar Header** — the heading area that prints the current period's
  title; it can embed the pager beside the title.
- **A date contextual filter** — this decides which period is shown, read from the
  URL. To open the calendar on today when no period is in the URL, set the
  argument's default value to the **Calendar Current date** plugin from the
  `calendar_datetime` submodule.

### Presentation

Every period type has its own Twig template and CSS, so you can restyle the
month/week/day/year grids, cells, dateboxes, and items by overriding templates in
your theme. A **Calendar Legend** block explains the stripe colors on any page.
