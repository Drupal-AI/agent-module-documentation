# Field Formatter Pattern — manual setup guide

**Field Formatter Pattern** (`field_formatter_pattern`) lets site administrators
add a custom HTML **pattern attribute** to text fields, configured directly in the
Field UI. Field output sometimes needs a specific HTML attribute — a `pattern`
constraint, or another attribute you want the field's markup to carry — and this
module provides a setting for that on text field formatters, so you can add it
without writing a custom module or theme override.

The setting appears as a small checkbox on each text field's formatter settings,
revealed by clicking the formatter's edit (gear‑wheel) button on the display
form. You then enter the pattern you want applied.

One thing to keep in mind: any mechanism that injects attributes into rendered
output should only carry trusted, static values. Because the pattern here is
configured by an administrator on the formatter — not derived from content an
untrusted user can supply — it is trusted by design. Still, confirm the patterns
you configure are fixed, safe values and never come from untrusted input, so they
cannot become an XSS vector (for example an `on*` event handler).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide configuration page** for this module. You set a pattern
per field, in the Field UI display settings, described below.

## Where it lives in the admin menu

Field Formatter Pattern adds no admin page of its own. You configure it from the
Field UI display settings for content types, users, and other entities — for a
node field, **Structure → Content types → *(type)* → Manage form display**
(`/admin/structure/types/manage/{type}/form-display`).

## How to use it

1. Go to the entity's display settings (for a node field, **Structure → Content
   types → *(type)* → Manage form display**).
2. For the desired text field, click the formatter settings edit button (the
   gear‑wheel / contextual icon).
3. Tick the pattern option and enter the **Pattern** you want the field output to
   carry.
4. Click **Update**, then **Save** the form.
