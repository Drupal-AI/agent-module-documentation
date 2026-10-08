# Multi Dates Picker — manual setup guide

**Multi Dates Picker** (`mdp`) adds a new field type for storing **several dates** at once,
using a multi‑date calendar picker (built on the jQuery UI Multidatespicker). Instead of a
single date, an editor selects any number of individual days on a calendar and they are
stored together as one field — ideal for event days, availability, or any content that
should appear on specific dates.

The field also carries a simple display convention based on how many dates you pick:

- **One date** is treated as a single date — the content shows on that day.
- **Two dates** are treated as a **range** — the content shows from the first date through
  the last.
- **Three or more dates** are treated individually — the content shows on each of them.

It is a field/content‑editing feature with no access role of its own. It depends on core's
Field module and on the jQuery UI Datepicker module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its jQuery UI Datepicker dependency.

Multi Dates Picker has no global settings form. You configure it per field, on the content
type where you add it, as described under "How to use it" below.

## Where it lives in the admin menu

Multi Dates Picker adds no dedicated admin page. You use it from **Structure → Content
types → *(your type)* → Manage fields**, by adding a Multi Dates Picker field, and editors
then choose the dates on the content edit form.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and **add a field**
   of type **Multi Dates Picker**.
2. Save the field settings. It behaves as a multi‑value date field.
3. When creating or editing content of that type, open the content's settings and use the
   calendar to **select the dates** you want — one for a single day, two for a range, or
   several for individual days.
4. Save. The content is then shown or hidden according to the selected dates, following the
   one/two/many rule described above.
