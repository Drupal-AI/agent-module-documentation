# Smart Date Range Formatter — manual setup guide

**Smart Date Range Formatter** (`smart_daterange_formatter`) is a field formatter
for Drupal core's Date Range (`datetime_range`) field type that knows the
difference between a range that stays inside one day and one that spans several.
When the start and end fall on the same calendar day, it prints the date once and
only varies the time — so you get clean output like *January 15, 2026, 9:00 AM –
5:00 PM* instead of the same date repeated twice. When the range crosses days, it
shows both full date/time values, for example *January 15, 2026 – January 18,
2026*.

The problem it solves is small but everyday: core's own date-range formatters
repeat the date on both ends even when it is identical, which reads awkwardly on
event listings, opening hours, and session schedules. This module collapses that
redundancy automatically, with no manual per-item editing.

It depends only on core's **Datetime Range** module — there are no third-party
libraries. It works as soon as you assign it to a field, but it gives you two
configurable date formats (one for same-day ranges, one for different-day ranges)
so you can match your site's style. Output fully respects the site timezone and
each user's own timezone setting, and honours the active interface language. A
lightweight Twig template (`smart-daterange.html.twig`) and a small, easily
overridden CSS file make it simple to theme.

This guide is written for a **human** configuring the field display through the
admin UI. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — assign the formatter to a Date Range
   field and set the same-day and different-day date formats.

## How to use it

Smart Date Range Formatter has no global settings page. It surfaces as a display
option on any **Date Range** field: go to the **Manage display** tab of the
content type (or other entity) that has the field, and choose *Smart Date Range*
as that field's format. See [Configuration](configuration/index.md) for the
per-field settings.
