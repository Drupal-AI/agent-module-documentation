# Month Year Range — manual setup guide

**Month Year Range** (`month_year_range`) provides form widgets for entering
dates at **month-and-year (or year-only) granularity** — the level of precision
that things like a CV entry, an exhibition run, a project period, or a course
term actually have. "March 2019 – July 2022" is how people describe employment,
study, and projects; storing that in a full date field forces you to invent a
day (`2019-03-01`), which then implies a precision nobody asserted and leaks into
displays and sorts. This module keeps the granularity honest.

It builds on Drupal core's **Datetime Range** module (`datetime_range`), which it
depends on, and it targets **Drupal 10 and 11**. It doesn't add a new storage
type of its own — instead it provides widgets you attach to date and date-range
fields on a bundle's *Manage form display*. (Worth knowing when reading a
Composer constraint: the version number `9.1.x` tracks the Drupal major it was
first built for, not semantic versioning.)

Two widgets are provided:

- **Month Year Range** — for **date range** fields (a start and end), rendered as
  month/year selectors.
- **Month Year Datetime** — for **single datetime** fields, rendered as a
  month/year (or year-only) selector.

There is **no admin settings page**. All setup happens on the field itself, in
*Manage form display* — see "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no global settings
form. Widget behaviour is configured per field, described below.

## Where it lives in the admin menu

Month Year Range adds no admin page of its own. You use it entirely from
**Structure → Content types (or any bundle) → *(your bundle)* → Manage form
display**, where you pick one of its widgets for a date or date-range field.

## How to use it

1. Create a **Date** or **Date range** field on your content type (or other
   fieldable entity) as you normally would. A range field pairs with the
   *Month Year Range* widget; a single date field pairs with *Month Year
   Datetime*.
2. Go to the bundle's **Manage form display** and, for that field, select the
   appropriate widget:
   - **Month Year Range** for a date-range field.
   - **Month Year Datetime** for a single date field.
3. Configure the widget's options (via its gear/settings on the same screen):
   - **Date order** — display and entry order: **Year/Month**, **Month/Year**,
     or **Year only** (drop the month entirely).
   - **Year range** — optionally restrict the selectable years, either as
     absolute values (`2020:2030`) or relative to the current year (`-5:+5`).
   - **Day handling** — since only month and year are entered, the widget can
     auto-set the stored day to the **first** or **last** day of the month.

Two things to establish for your content before you rely on it:

- **Open-ended ranges** — "March 2019 – present" is the common case for a current
  role. Confirm how your field represents an open end and that your display
  formatter handles it, rather than leaving it as a null the formatter might
  mishandle.
- **Sorting and filtering** — a month-year value ordered as a string behaves
  differently from one ordered as a date. If you sort or filter on the field
  (for example in a View), check the result before depending on it.
