# Smart Date — manual setup guide

**Smart Date** (`smart_date`) is a smarter date/time field for Drupal that behaves
more like a modern calendar app. Instead of two separate, fiddly date fields, it
stores a start time, an end time, and a duration together in one `smartdate`
field. The editing widget lets people pick a duration that auto-fills the end
time, flag an event as all-day, and choose common presets — and on display it
collapses the redundant parts intelligently, rendering something like
"Mon, Jan 6, 2025, 5–7pm" instead of spelling out both full timestamps.

It's a field type, so it doesn't add anything visible until you *use* it: you add
a Smart Date field to a content type (or any fieldable entity), then choose one of
its widgets for editing and one of its formatters for display. Several of each
ship with the module — an app-like default widget, an inline variant, a timezone
widget, and a select-list widget; and default, plain, custom, and duration
formatters. The compact "smart" display is driven by reusable **Smart date
format** configuration entities that you manage in the admin UI and can share
across every Smart Date field on the site.

The module depends only on core's **Datetime** and **Options** modules (both
enabled automatically), needs **PHP 8.1+**, and pulls in the `simshaun/recurr`
library via Composer for recurring-event support. The optional **Smart Date
Recurring** submodule (`smart_date_recur`) adds RRULE-based recurring events, with
per-instance overrides, cancellations, and rescheduling. Smart Date also
integrates with Views, Feeds, Migrate, Diff, and FullCalendar View, and ships a
Drush command to migrate legacy datetime/daterange fields over to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the Recurring submodule.
2. [Configuration](configuration/index.md) — adding a Smart Date field, choosing
   widgets and formatters, and managing reusable Smart date formats.

## Where it lives in the admin menu

Smart Date has no single settings page. Its main configuration UI is the reusable
**Smart date formats** collection at **Configuration → Regional and language →
Smart date formats** (`/admin/config/regional/smart-date`), where you create and
edit the named formats that control the compact display. The field itself is set
up per content type through the usual **Manage fields / Manage form display /
Manage display** screens. See [Configuration](configuration/index.md).
