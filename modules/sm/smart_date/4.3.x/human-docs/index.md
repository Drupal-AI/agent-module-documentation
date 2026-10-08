# Smart Date — manual setup guide

**Smart Date** (`smart_date`) is a more user-friendly date field that makes Drupal's
date handling feel like a modern calendar app. Its field type stores a **start
time, end time, and duration** together, and its widget lets editors pick a
duration that auto-fills the end time, mark an event as **all-day** with one
checkbox, and choose common presets. On display it intelligently collapses
redundant parts — hiding the end date when it matches the start, dropping the year
for the current year, and rendering time ranges compactly (e.g. "Mon, Jan 6, 2025,
5–7pm").

How output looks is controlled by reusable **Smart date format** configuration
entities, so you define a display style once and reuse it across fields, views, and
displays. Several field formatters ship (default, plain, custom, duration), and the
formatting logic is available to code as well. The optional **Smart Date
Recurring** submodule (`smart_date_recur`) adds RRULE-based recurring events —
powered by the `simshaun/recurr` PHP library — with per-instance overrides,
cancellations, and management UIs.

Smart Date depends only on core's **Datetime** and **Options** modules, making it a
lightweight but powerful replacement for date-range fields on event-driven sites.
It integrates with Views, Feeds, Migrate, Diff, and FullCalendar View, and provides
a Drush command to migrate legacy datetime/daterange fields to Smart Date. This
4.3.x release supports Drupal 10, 11, and 12 (core 9 support was dropped) and
requires PHP 8.1 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the Recurring submodule if you need it.
2. [Configuration](configuration/index.md) — add a Smart Date field, choose a
   widget and formatter, and manage reusable Smart date formats.

## Where it lives in the admin menu

Reusable display formats are managed at **Configuration → Regional and language →
Smart date formats** (`/admin/config/regional/smart-date`), which requires the
*Administer site configuration* permission. The field itself is added and configured
on your content type's **Manage fields**, **Manage form display**, and **Manage
display** screens like any other field.

## How to use it

1. Add a **Smart date** field to a content type (for example an *Event* type).
2. On **Manage form display**, choose a Smart Date **widget** — the default
   app-like widget, an inline variant, a timezone-aware widget, a select-list
   variant, or a date-only range widget.
3. On **Manage display**, choose a Smart Date **formatter** and, for the *custom*
   formatter, pick which Smart date format to apply.
4. Optionally enable **Smart Date Recurring** for repeating events, or install the
   Smart Date Starter Kit / Calendar Kit to scaffold an Event content type and view
   quickly.
