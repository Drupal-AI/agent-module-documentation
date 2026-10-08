# Date Recur Interactive Widget — manual setup guide

**Date Recur Interactive Widget** (`date_recur_interactive`) provides a friendly,
visual form widget for entering recurring dates on **Recurring Dates Field**
(`date_recur`) fields. Instead of asking an editor to write raw RRULE recurrence
strings, it offers an interactive editor for building the repeat rule — setting
the recurrence pattern, the end condition, and include/exclude dates — with a
preview of the resulting occurrences.

The widget was originally forked from the one that shipped with Recurring Dates
Field and has been revived for Drupal 10 and 11, with a number of long‑standing
date, timezone, and RRULE‑generation bugs fixed and regression tests added. It's a
content‑editing feature: it changes how recurrence is *entered*, and has no content
or access‑control role of its own. It depends on the **Recurring Dates Field**
(`date_recur`) module (3.x).

A word of caution from the maintainers: this is a **beta** (3.0.0‑beta1), and
recurrence data can be hard to correct once it's been saved incorrectly. If your
site has complex recurrence requirements, test the widget carefully — especially
timezone handling and include/exclude dates — before using it in production. (For
sites that prefer smaller, purpose‑specific widgets over one combined editor,
*Recurring Date Field Modular Widgets* is a viable alternative.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Recurring Dates Field.

There is **no configuration page** — you select the widget on a field's *Manage
form display*, as described below.

## How to use it

1. Make sure you have a **Recurring Dates Field** (`date_recur`) field on your
   content type or other entity.
2. Go to that entity's **Manage form display** (for example **Structure → Content
   types → *(type)* → Manage form display**).
3. For the recurring‑date field, set the **Widget** to the **Date Recur
   Interactive** widget.
4. Save. Editors now get the visual recurrence editor — with occurrence preview and
   include/exclude dates — when they create or edit content, instead of typing raw
   RRULE values.
