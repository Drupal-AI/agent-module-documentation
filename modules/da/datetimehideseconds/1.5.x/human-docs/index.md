# DateTime Hide Seconds — manual setup guide

**DateTime Hide Seconds** (`datetimehideseconds`) adds a small "Hide seconds"
toggle to Drupal's core Date/time field widgets. When you turn it on for a field,
the time input on the entity edit form only accepts hours and minutes — the
seconds spinner disappears — so editors enter times like `14:30` instead of
`14:30:00`. It is a friendly, minute-granularity tidy-up for datetime fields where
seconds are just noise (event start times, publish times, booking slots, and the
like).

The module is intentionally tiny. It does not add a field type, a new widget, a
settings page, or any permission. Instead it adds a single **Hide seconds**
checkbox to the existing core Date/time widgets on the **Manage form display**
screen. Tick it for a field, and that field's time input drops the seconds. The
change affects only the editing widget — stored values and how the field is
displayed are untouched; a saved time simply ends in `:00` because the widget never
lets you type otherwise. It has no effect on date-only fields, which have no time
input to simplify.

It depends only on core's **Datetime** module (`datetime`) and works on Drupal
8.7.7+, 9, 10, or 11. The checkbox appears on the standard *Date and time* and
*Select list* datetime widgets, and — if you use the Datetime Range module — on
its range widgets too (hiding seconds on both the start and end inputs at once). It
ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact hooks, the
`step=60` mechanism, and where the setting is stored — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. The toggle lives on each entity's **Manage form
display** screen — for example **Structure → Content types → Article → Manage form
display** (`/admin/structure/types/manage/article/form-display`).

## How to use it

1. Go to the **Manage form display** page for the bundle whose datetime field you
   want to simplify (and the form mode you care about — you can hide seconds on the
   default form but not on a custom one, for instance).
2. Click the **gear/cog** icon on the datetime field's row.
3. Tick **Hide seconds**. (Its description notes it has no effect if the field has
   no time widget.)
4. Click **Update**, then **Save**. The field's widget summary will then read
   *Hide seconds.*

From then on, that field's time input accepts only `HH:MM`. In browsers that
support the HTML5 time input, the seconds spinner is removed natively (the module
sets the input's `step` to 60 seconds). To turn it back off, untick the box and
save. The setting is stored per field and per form mode, so it exports with your
form-display configuration for deployment.
