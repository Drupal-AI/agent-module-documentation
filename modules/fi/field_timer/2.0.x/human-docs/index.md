# Field Timer — manual setup guide

**Field Timer** (`field_timer`) adds field formatters that display a core
**datetime** field as a live counting timer or countdown instead of a static
date. Point it at an event's start date and visitors see "starts in 3 days
04:12:07"; point it at a publication date and they see an elapsed timer ticking
upward. Nothing about your stored data or field type changes — this is purely a
display option you choose on a field's *Manage display* page.

The module ships four formatters. One is a lightweight, server-rendered text
formatter that needs no extra software; the other three are animated JavaScript
widgets that each require a small front-end library to be installed:

- **Text timer or countdown** (`field_timer_simple_text`) — no external library.
  A single **type** setting decides whether it shows past dates as a running
  timer, future dates as a countdown, or both automatically.
- **jQuery Countdown** (`field_timer_countdown`) — a ticking countdown animated in
  the browser, with rich formatting options (format string, layout, compact mode,
  granularity, separator, zero-padding, and localized labels).
- **jQuery Countdown LED** (`field_timer_countdown_led`) — an LED-style countdown
  with a green or blue theme and toggles for showing days/hours/minutes/seconds.
- **County** (`field_timer_county`) — a stylized animated countdown with
  fade/scroll animation, speed, color themes, background, and a reflection effect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (for the JavaScript formatters) add the required libraries.

## Where it lives in the admin menu

Field Timer has no settings page of its own. You choose a Field Timer formatter
on an entity's **Manage display** page — for a content type that's **Structure →
Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/<bundle>/display`).

## How to use it

1. Enable the module, and — if you want one of the JavaScript widgets — place the
   matching library (see [Installation](installation/index.md)).
2. Make sure the entity has a **datetime** field (for example an event date).
3. Go to the entity's **Manage display** page, find that field's row, and pick one
   of the Field Timer formatters from the **Format** column.
4. Click the gear/settings icon on the row to adjust that formatter's options:
   - **Text timer or countdown** — set **type** to *auto*, *timer* (past dates
     only), or *countdown* (future dates only), plus the inherited date-format and
     granularity settings.
   - **jQuery Countdown** — format string, layout, compact display, significant
     units, time separator, zero-padding, and language.
   - **jQuery Countdown LED** — theme (green/blue), a maximum day count, and which
     of days/hours/minutes/seconds to show.
   - **County** — animation (fade/scroll), speed, color theme, background, and
     reflection.
5. **Save**. You can apply different formatters per view mode — for example a
   compact "time since posted" timer on teasers and a full countdown on the full
   page — because the choice is stored per field, per view mode.

> **Tip:** If you don't want to install any front-end library, use **Text timer or
> countdown** — it renders on the server and works out of the box.
