# Datetime Extras — manual setup guide

**Datetime Extras** (`datetime_extras`) fills in some gaps in Drupal core's date
handling. Core gives you Datetime and Datetime Range fields, but the editing
options are limited — there's no time-only field, the "select list" date widget
always forces a time input, and date ranges always want an explicit end. This
module adds a **time-only field type**, several extra **widgets**, and a matching
**formatter** so you can capture and display dates and times the way your content
actually needs.

Everything it adds is configured **per field** on the usual **Manage fields**,
**Manage form display**, and **Manage display** tabs — there is no global settings
page, no permissions, and nothing to switch on beyond the field configuration
itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Datetime Extras adds no menu items and has no settings screen. You use it on any
fieldable entity under **Structure → Content types → *(your type)* → Manage
fields** (to add a time-only field) and on the **Manage form display** / **Manage
display** tabs (to pick its widgets and formatter).

## How to use it

### A time-only field

To store just a time of day with no date — a store's opening time, a recurring
reminder — add a field of type **Time only** (`time_only_field`) on **Manage
fields**. It comes with its own time widget for entry and a time formatter for
display; on **Manage display** the formatter lets you choose a date format and,
if needed, override the timezone.

### Extra widgets for core Datetime fields

On **Manage form display** for a core **Date** (datetime) field, you can switch
to one of these widgets:

- **Select list, no time** (`datetime_datelist_no_time`) — day/month/year
  dropdowns with **no** time input. (Core's own select-list widget always
  includes a time; this one doesn't.) Good for birthdays or publish dates where
  the time is irrelevant. You can set the field's date order, 12/24-hour type,
  minute increment, and year range.
- **Configurable Date and time** (`datatime_configurable`) — a date/time widget
  where you set a bounded **year range** (for example `-3:+3`) and a minute
  **increment** (for example every 15 minutes, so appointment slots snap to
  `:00/:15/:30/:45`).
- **Configurable list** (`datatime_extras_configurable_list`) — **deprecated**.
  Avoid on new fields; it exists only for sites that already use it.

### A duration widget for core Date range fields

On **Manage form display** for a core **Date range** (daterange) field, the
**Date and time range with duration** widget (`daterange_duration`) lets an
editor set a **start** and then either an absolute end (like core) or a relative
**duration** — for example "start at 2pm, lasts 2 hours." You can set a default
duration, the granularity of duration entry (years/months/days/hours/minutes),
and a time increment.

> **Note:** the duration widget requires the contrib **Duration Field** module
> (`drupal/duration_field`, version 8.x-2.0-rc3 or newer). Until that module is
> installed and enabled, this widget is hidden and won't appear in the widget
> list. See [Installation](installation/index.md).
