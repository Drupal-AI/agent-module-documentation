# Multiple Dates — manual setup guide

**Multiple Dates** (`multiple_dates`) provides an advanced multiple‑date picker
field for Drupal. Instead of a single date, or a start‑to‑end range, it lets an
editor open a calendar and click **several individual dates** — dates that need
not be in sequence — and store them all in one field. It is implemented with a
calendar picker and, importantly, has **no external JavaScript library
dependencies** to install; it depends only on core's **Field** module.

Reach for it whenever content needs a *set* of specific dates rather than one:
event occurrence dates, availability days, opening or closure dates, and so on.
The widget is flexible — you can allow date ranges, cap the maximum number of
dates a user may pick, offer a rolling "pick Y dates within the next X days"
window, disable specific dates or specific weekdays, set minimum and maximum
bounds, and show more than one month at a time.

The dates are stored as ordinary field values, so the module has no content or
access‑control role of its own — it is purely a field type plus its widget and
formatter. All of the setup happens in **Field UI**: you add the field to a
bundle, then tune the widget on *Manage form display* and the output on *Manage
display*. There is no site‑wide settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You configure it per field, described in "How to use it" below.

## How to use it

Everything happens in **Field UI**, so make sure core's Field UI module is
enabled if you want to click through it.

1. Go to the bundle you want to add dates to — for example **Structure → Content
   types → *(your type)* → Manage fields** — and choose **Add field**.
2. Pick **Multiple Dates** as the field type, give it a label, and save. Set the
   field's cardinality as you would any field.
3. On the bundle's **Manage form display** tab, the Multiple Dates widget offers
   options such as: the **date select type**, a **maximum number of picks**, a
   **days range** (allow Y dates within the next X days), **disable specific
   dates**, a **minimum** and **maximum** date, **disable specific weekdays**,
   and the **number of months** to show at once.
4. On the bundle's **Manage display** tab, the formatter lets you set the
   **months display layout**, the **date format**, and the **number of months**
   shown in the output.

Editors then see a calendar on the content form and click each date they want to
record.
