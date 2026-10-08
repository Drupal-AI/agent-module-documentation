# DateTime Range Until Now — manual setup guide

**DateTime Range Until Now** (`datetime_range_until_now`) extends core's date
range field with an explicit **"Until now"** option, for periods that started and
have not ended.

A core date range with a required end date cannot cleanly express the most common
state of anything ongoing — a job that started in 2019 and continues, a course
still running, a membership that has not lapsed, an exhibition still open. The
usual workarounds are all flawed in the same way: leaving the end date empty makes
"ongoing" indistinguishable from "we forgot to fill this in"; putting a far-future
placeholder date in makes a listing claim the role ends in 2099 and breaks any
sort by end date; and a separate "current" checkbox creates two fields that can
disagree, so a record can be marked both current *and* ended. This module adds
"until now" as a genuine third state inside the field, which is what the data
actually is.

Concretely, it adds an **"Until now" field setting** to the core `daterange`
field type. When that setting is on, the field carries a third value
(`until_now`) alongside the start and end values; the provided **widget** makes
the end date optional; and the provided **formatter** renders the field like
"01.01.2022 – Until now".

Two consequences follow from the semantics, both worth understanding before you
rely on it. **"Now" is evaluated when the field is rendered, not when it is
saved** — so an "ongoing" record is a live statement, and the render cache must
expire or a page can keep saying "to present" after someone has added an end date.
And **sorting and filtering need a decision**: an ongoing period has no end value
to compare, so a view sorted or filtered by end date has to decide how ongoing
records behave.

The module works once enabled and the field setting is switched on per field;
there is no central settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn on the **"Until now"**
option in a date-range field's settings, and select the module's widget and
formatter on the field's *Manage form display* and *Manage display* tabs.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage fields** (edit a Date range field and enable the **Until
now** setting), then set the widget on **Manage form display** and the formatter on
**Manage display** so the end date becomes optional and renders as "… – Until now".
