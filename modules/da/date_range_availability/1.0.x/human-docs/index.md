# Date Range Availability — manual setup guide

**Date Range Availability** (`date_range_availability`) works out, from an
entity's date‑range field, whether that entity is currently **available**,
**unavailable**, or **coming soon**, and gives you two ways to show that state:
a Twig function for your theme templates and a global field for Views. It's a
natural fit for event management, e‑commerce, booking systems, and any content
whose availability depends on a date window.

Rather than storing a separate "status" flag you have to keep up to date, the
module derives the state on the fly from a date‑range field you already have. Point
it at a field (by its machine name) and it compares the range against the current
date to decide the state. It depends on core's **Datetime Range** (which provides
the date‑range field type) and **Views**.

This is primarily a display/site‑building feature — it reads and reports
availability windows and has no access‑control role. It works once you have a
date‑range field in place; the "setup" is telling the Views field or the Twig
function which field to read.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Datetime Range and Views.

There is **no configuration page** — you configure it per Views field or per
template call, as described below.

## How to use it

**In a View:**

1. Edit a View that lists entities carrying a date‑range field.
2. Add the **Availability** field to the View.
3. In its settings, enter the **machine name** of the date‑range field to read
   (for example `field_date`).
4. Save. Each row now shows that entity's current availability state.

**In a theme template**, use the `node_availability()` Twig function, passing the
node and the date‑range field's machine name:

```twig
{% set state = node_availability(node, 'field_date') %}
{{ state.label }}
```

The returned value carries the state's label (e.g. *Available*, *Unavailable*,
*Coming Soon*) for you to print or act on.
