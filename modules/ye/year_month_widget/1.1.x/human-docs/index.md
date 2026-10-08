# Year/Month Widget — manual setup guide

**Year/Month Widget** (`year_month_widget`) adds a form widget for core **Date/time**
(`datetime`) fields that lets editors pick only a **year and a month** — two select
dropdowns, no day — instead of a full date. It's for the cases where a day would just
be meaningless data‑entry noise: a card expiry (MM/YYYY), a subscription start month,
an employment or education period, a magazine issue, a budget or report period.

The clever part is that it rides on Drupal's standard datetime storage, so the value
saved is still a normal full datetime (the day and time simply default in). That means
the field keeps working with Views, tokens, and anything else that consumes datetime —
you're only changing how it's *entered*, not how it's stored.

Two small per‑field settings control it: the **order** of the dropdowns (Year/Month or
Month/Year) and an optional **year range**. There's no admin settings page,
permissions, or Drush — you just pick the widget on a field's form display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's Datetime module.

## How to use it

There's no admin menu item — you select this widget per field on an entity's **Manage
form display** tab (`/admin/structure/…/form-display`). It's offered for any field of
type **Date/time** (`datetime`).

1. Go to the **Manage form display** tab of the content type (or other entity) and the
   form mode you want to change.
2. Find your Date/time field and change its **Widget** to **Year/month**.
3. Click the widget's cog to set its two options:

| Setting | Default | What it does |
|---|---|---|
| **Part order** | `YM` (Year, then Month) | Choose `YM` (Year/Month) or `MY` (Month/Year) for the dropdown order. |
| **Year range** | *(empty = core default)* | Which years appear. Accepts a relative range like `-3:+1` (three years back to one ahead), an absolute range like `2000:2010`, or a mix like `2000:+3`. An invalid value shows a form error. |

4. Click **Update**, then **Save**.

On the form the field now renders as a clean two‑dropdown fieldset showing just year
and month. The saved value remains a full datetime with the day/time defaulted, so
downstream datetime logic still works. See the sibling
[`agent/configure/widget.md`](../agent/configure/widget.md) for the storage shape and a
Drush example.
