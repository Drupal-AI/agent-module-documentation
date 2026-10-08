# Timestamp Nullable — manual setup guide

**Timestamp Nullable** (`timestamp_nullable`) provides a timestamp field widget that
lets a value be left genuinely **empty (null)** instead of quietly defaulting to the
current date and time.

The problem it solves is a small but real annoyance. Drupal core's *Datetime
Timestamp* widget automatically fills an empty timestamp field with "now" when the
form is submitted — so a content editor who leaves the field blank ends up with the
current time stored anyway. For optional date/time fields, where "no value" is a
meaningful state ("this hasn't happened yet", "we don't know the date"), that is the
wrong behaviour. Timestamp Nullable is a drop-in replacement widget that gives
editors explicit control: an empty field can stay empty.

It is configurable per field. On the widget's settings you choose whether empty
values should remain **NULL/empty**, or fall back to the original core behaviour of
defaulting to the current time — so you can adopt it selectively where nullable
timestamps matter and leave everything else as it was.

The module is a pure content-editing/form-widget feature: it affects how a timestamp
is entered and saved, and has no role in content access or display. It has no
dependencies beyond core and targets Drupal 11. (This is an alpha release and is not
covered by drupal.org's security-advisory policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no central settings page — you select the widget on the field you want to
make nullable:

1. Go to **Structure → Content types → *your type* → Manage form display** (or the
   equivalent "Manage form display" tab for whatever entity holds the timestamp
   field).
2. For your timestamp field, choose **Datetime Timestamp (Nullable)** as the widget.
3. Click the **gear icon** beside the widget to open its settings, and choose
   whether empty values should **remain NULL/empty** or **default to the current
   time** (the original core behaviour).
4. Save the form display.

From then on, editors can leave that timestamp field blank and it will be stored as
empty rather than being set to "now".
