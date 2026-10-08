# Grid Widget — manual setup guide

**Grid Widget** (`grid_widget`) is a field widget that renders checkbox and radio
selections as a styled **CSS grid** instead of a plain vertical list. If you have
a field with a long, unwieldy list of allowed options, this tames it: the choices
lay out in responsive columns, which is far easier to scan and pick from on an
entity edit form than a single tall column of checkboxes.

It works on the field types that expose a fixed set of allowed values —
list/text fields, numeric fields, and entity reference fields — and supports both
single-select (radio buttons) and multi-select (checkboxes). Under the hood it
extends Drupal core's options widget, so the underlying selection behavior and
the field's allowed-values constraints are unchanged; it only changes how the
options are *presented*. The module also ships template suggestions and asset
libraries so modules and themes can customize the grid further.

This is purely a form/display-layer widget. It does not add access control and it
doesn't change which values a user may set beyond the field's own allowed-values
constraints — content access and field access are exactly as they were.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings page** for this module. You select and tune the
widget per field, on the **Manage form display** screen, described below.

## How to use it

The widget is chosen per field instance:

1. Go to the bundle whose field you want to change — for example **Structure →
   Content types → *(your type)* → Manage form display**.
2. Find your options field (a list/text, numeric, or entity reference field with
   allowed values) and, in the **Widget** column, choose the **Grid Widget**
   option (in place of the default options buttons widget).
3. Click the widget's gear/settings icon to configure the grid styling (such as
   the column layout) exposed by the widget settings.
4. Save. On the entity's edit form, that field's options now render as a
   responsive grid of checkboxes or radios.
