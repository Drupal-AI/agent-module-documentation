# Calendar Systems — manual setup guide

**Calendar Systems** (`calendar_systems`) localizes the dates on your Drupal site
into non-Gregorian calendars — principally the Persian / Jalali (Shamsi) calendar.
Once enabled, formatted dates across the site render in the active calendar and
language: node created/changed dates, date tokens, date field widgets, Views date
filters and arguments, and a bundled date block.

The clever part is that it mostly works **automatically**. The module swaps
Drupal's core `date.formatter` service for its own, so virtually any date that's
formatted the normal way comes out in the chosen calendar without you touching
each display. It also replaces the core date form elements and field widgets with
calendar-aware versions and attaches a bundled Persian date-picker to date inputs,
so editors enter dates in the localized calendar too. The calendar is chosen from
the current interface language (Farsi → Persian, English → Gregorian, configurable
per site).

Because everything becomes localized, the module adds special `[date:gregorian]`
tokens you can use where you deliberately want plain Gregorian output — for
example machine-readable metadata and SEO tags — while human-facing dates stay
Jalali. It also normalizes Persian digits and Farsi relative-date words on input.
Two submodules extend it to **Better Exposed Filters** date forms and to the
**FullCalendar** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pick the submodules you need.
2. [Configuration](configuration/index.md) — what happens automatically, how the
   calendar is chosen, the optional Calendar Systems block, and the Gregorian
   escape tokens.

## Where it lives in the admin menu

There is **no dedicated settings page** — the module has no `configure` route.
Localization is applied globally the moment you enable it. The one thing you place
by hand is the **Calendar Systems** block, added like any block through
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

Enable the module and your site's dates immediately localize based on the
interface language. From there, the optional pieces are: place the Calendar Systems
block if you want a standalone current-date display, use the `[date:gregorian]`
tokens where you need Gregorian output, and enable a submodule for BEF or
FullCalendar integration. See [Configuration](configuration/index.md) for details.
