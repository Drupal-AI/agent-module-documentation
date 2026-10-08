# Single DateTimePicker — manual setup guide

**Single DateTimePicker** (`single_datetime`) replaces Drupal core's separate
date and time boxes with a single input that opens one combined calendar-and-
clock popup. It is powered by the xdan jQuery DateTimePicker library, so editors
get a consistent, mobile-friendly picker instead of the browser's native date
controls.

The module provides field **widgets** you assign to core date fields on an
entity's *Manage form display* page: one for `datetime` fields, one for
`timestamp`/`created` fields, and (through the optional *Single DateTime Range*
submodule) one for `daterange` fields. There is no global settings page —
everything is configured per field, per form mode. Each widget offers a rich set
of options: 12-hour or 24-hour clock, minute granularity (5/10/15/30/60), allowed
hours, greyed-out weekdays, blocked dates, a light or dark theme, minimum and
maximum dates, an inline (always-visible) mode, an input mask, and more. Together
these let you build things like an appointment-slot picker that only offers
business hours in 15-minute steps.

One important prerequisite: the widget needs the external xdan library installed
at `/libraries/jquery-datetimepicker`. Without it the field quietly falls back to
a plain text box (nothing breaks, but you lose the picker).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   xdan JavaScript library, then enable it.
2. [Configuration](configuration/index.md) — assign the widget to a field and
   tune its settings, one option at a time.

## Where it lives in the admin menu

Single DateTimePicker has no admin page of its own. You use it from **Manage form
display** on whatever entity has the date field — for a content type that is
**Structure → Content types → (your type) → Manage form display**
(`/admin/structure/types/manage/<type>/form-display`) — by choosing one of its
widgets for a date, timestamp, or date-range field.
