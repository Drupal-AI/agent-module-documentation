# Migrate Source iCal — manual setup guide

**Migrate Source iCal** (`migrate_source_ical`) adds a Migrate *source plugin*
that reads **iCalendar (iCal) data** — from a Google Calendar feed or a `.ics`
file — and exposes each calendar event as a migration row. That lets you import
calendar events into Drupal as content (nodes, or whatever event entity you use)
through a normal migration.

It solves a small but real integration problem: calendars are a common source of
"events" content, but they arrive in the iCalendar format rather than in a
database or spreadsheet Migrate already understands. This plugin parses that
format so the events flow through the standard Migrate pipeline like any other
source.

It's a focused, developer‑oriented plugin: it depends only on core **Migrate**,
adds no admin UI, and is used entirely from your migration YAML. If your source is
a remote calendar (a Google Calendar URL, for instance), note that the plugin
fetches it over the network at migration time, so your server needs outbound
egress to that URL, and you should point it only at calendar feeds you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

Use the plugin as the `source` of a migration and point it at your iCal feed or
file, then map the event's properties (such as summary, description, start and
end times) onto your destination entity's fields in the `process` section, and run
`drush migrate:import` as usual.

Because this is a minimally maintained plugin without an extensive published
option reference, the most reliable way to confirm the exact source field names it
exposes for your calendar is to add a temporary debugging step to the pipeline
(for example the `vardump` process plugin, or a `hook_migrate_prepare_row()`) and
inspect a row while building the migration. Then map those fields to your event
content type.
