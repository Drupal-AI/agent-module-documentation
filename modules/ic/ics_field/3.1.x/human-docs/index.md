# iCalendar Field — manual setup guide

**iCalendar Field** (`ics_field`) adds a **Calendar download** field type to
Drupal. Put it on an event content type (or any fieldable entity) alongside a
regular Datetime field, and it generates a downloadable `.ics` (iCalendar) file
so visitors can add the event to their own calendar with one click.

You control the calendar entry's **summary**, **description**, and **URL** on the
field, and both the summary and description support **tokens** (like
`[node:title]`), so you can pull the values straight from the entity. The field
points at a sibling Datetime field for the actual event date(s) — if that date
field holds multiple values, the module emits one calendar event (VEVENT) per
date. The generated file is rebuilt automatically whenever the entity is edited,
and the event's UID stays stable across edits so a re-imported `.ics` updates the
same event in someone's calendar rather than duplicating it.

Under the hood it uses the `eluceo/ical` library to build a standards-compliant
file and `html2text` to produce a plain-text description for calendar clients
(while also emitting an HTML alternative). The finished file is stored as a
managed file in the public files directory by default, which means it is
**downloadable without logging in** — that is intentional, since a calendar file
is meant to be shared. If your event details must stay private, point the field
at a private file scheme and apply your own access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP
   libraries with Composer, and enable it.

## Where it lives in the admin menu

There is **no module settings page** — everything is configured on the field you
add. You work with it under **Structure → Content types → (your type) → Manage
fields** and the matching **Manage form display** / **Manage display** tabs.

## How to use it

1. Make sure the content type (or other entity bundle) already has a core
   **Datetime** field for the event date — the calendar field references it.
2. On the bundle's **Manage fields**, add a new field of type **Calendar
   download**.
3. In the field's **storage settings**, choose:
   - **Date field reference** (required) — which Datetime field on the bundle
     supplies the event dates.
   - **File directory** — the subdirectory for the generated files (default
     `icsfiles`; supports tokens).
   - **URI scheme** — `public` by default. Use a private scheme if the events
     must not be downloadable anonymously.
4. On the **Manage form display**, the field's widget gives editors **Summary**,
   **Description**, and **URL** inputs, plus a click-to-insert **token list** of
   the entity's fields. Summary and Description are token-replaced against the
   host entity when the file is generated.
5. On the **Manage display**, the field's formatter renders an **iCal Download**
   link that points at the generated file.

Once configured, editing an event and saving it (re)generates its `.ics` file
automatically. Files are tracked in Drupal's file-usage system, so they are
cleaned up when the entity or field is removed.
