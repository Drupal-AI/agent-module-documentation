# Partial Datelist — manual setup guide

**Partial Datelist** (`partial_datelist`) lets you simplify date entry by hiding
the parts of a date or time you do not need to collect. Drupal's **Select list**
widget for date and date/time fields shows a full set of dropdowns — year, month,
day, hour, minute, second — but many fields only ever need some of those. A
year‑only field for a historical record, or a year‑and‑month field, does not need
day, hour, and second dropdowns cluttering the form.

This module hooks into Drupal's field‑widget configuration so you can deactivate
individual date or time components on the **Select list** widget. It works with
both **Datetime** and **Datetime Range** field types, and the setup happens right
in the widget settings on a field's *Manage form display* — there is no separate
settings page.

One behavior to keep in mind: hiding a dropdown does not remove that component from
the stored value — it just stops asking the user for it. A hidden component still
contributes a value (for example, hiding **seconds** means seconds default to
zero). Make sure the components you hide have sensible defaults for your data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central configuration page** — you configure Partial Datelist per
field, in the widget settings described under "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage form display** (or
   the equivalent *Manage form display* for any entity that has a Datetime or
   Datetime Range field).
2. Make sure the field in question uses the **Select list** widget.
3. Click the widget's settings (the gear icon). With Partial Datelist enabled, you
   will see options to **hide specific date or time parts** — year, month, day,
   hour, minute, second.
4. Tick the components you want to hide, then **Update** and **Save** the form
   display.

The chosen dropdowns disappear from the entry form for that field. Before you rely
on it, confirm that each hidden component's default value makes sense for the data
you are collecting.

## Upgrading note

Version 1.1.x replaced this module's older procedural hook functions with
attribute‑based hook implementations. If you are upgrading from 1.0.x, run database
updates immediately after deploying (`drush updb`, or visit `update.php`) —
otherwise the site may hold a cached reference to the removed functions and error
out until the update runs.
