# Time Zone (tzfield) — manual setup guide

**Time Zone** (`tzfield`) provides a **time zone field type** that stores a
standard tz-database identifier such as `Europe/London` or `America/New_York` on any
fieldable entity. It's useful whenever an entity represents something that has a
location or a time zone of its own — a city, an office, a store, a station, an event,
or a user profile — and you want to record and display that zone.

The field is a simple select list under the hood: its allowed values come straight
from PHP's list of tz-database identifiers, so it always matches the system's zone
database. Per-field settings let you exclude zones you don't want offered, and
default a new value to the site's default time zone and/or the current user's own
time zone.

Two widgets and two display formatters ship with it, so you can present the field
either as a plain region-grouped picker or one sorted by current UTC offset, and
display it either as the raw identifier or as the *current* local time in that zone.

The module works as soon as you enable it — there is no admin settings page or
configure route. You add and configure the field through Drupal's normal **Field UI**,
exactly like any other field type. It has no module dependencies of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
configure it per field through the Field UI, described in "How to use it" below.

## Where it lives in the admin menu

Time Zone adds no admin page. You use it entirely through the **Field UI** — add the
field to a content type, taxonomy vocabulary, user, media type, or any fieldable
entity at **Structure → … → Manage fields**, then configure its widget under
**Manage form display** and its formatter under **Manage display**.

## How to use it

1. Go to the bundle you want (for example **Structure → Content types → Event →
   Manage fields**) and click **Add field**.
2. Choose the **Time zone** field type and give it a label (for example "Venue time
   zone").
3. On the field settings, optionally:
   - **Exclude** specific time zones you don't want offered.
   - Default new values to the **site's** default time zone (`default_site`) and/or
     the **current user's** configured time zone (`default_user` — offered only when
     user time zones are configurable).
4. Under **Manage form display**, pick the widget:
   - **Time zone** (`tzfield_default`) — a select grouped by region.
   - **Time zone with current offset** (`tzfield_offset`) — a select sorted by, and
     labelled with, each zone's current UTC offset, e.g. `(UTC+01:00) Europe/London`.
5. Under **Manage display**, pick the formatter:
   - The default **basic string** formatter prints the raw identifier
     (`America/New_York`).
   - **Formatted current date** (`tzfield_date`) renders the *current* time in that
     zone using a PHP date format string you supply (default `T`, e.g. `GMT`) — for
     example use `g:i a T` to show the live local time.

Once the field is in place, editors pick a zone when they create or edit the entity,
and your chosen formatter renders it on display. In custom code the stored identifier
can be fed straight into `DrupalDateTime::setTimezone()`.

> **Version note:** Time Zone 2.0 requires Drupal `^11.1 || ^12` (Drupal 8/9/10 are
> no longer supported). The field's behavior, settings, and storage are unchanged
> from earlier versions.
