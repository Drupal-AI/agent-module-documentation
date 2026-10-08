# Existing Values Autocomplete Widget — manual setup guide

**Existing Values Autocomplete Widget** (`existing_values_autocomplete_widget`)
tackles the way free‑text fields quietly drift apart. Left to themselves, a
"Department" or "Location" text field ends up holding "Manchester", "manchester",
and "Manchester " as three different values, because nothing ever showed the
editor what had already been typed. This module turns a plain text field into an
**autocomplete** that suggests the values already entered in that same field, so
editors reuse existing labels instead of inventing new spellings.

It's the middle path between two heavier options. A taxonomy reference enforces
consistency but adds a vocabulary to maintain, permissions to manage, and a change
to your data model; a text field with a fixed "allowed values" list is rigid and
can't grow. With this widget the field **stays a text field** — editors can still
add brand‑new values freely — but every time they type, they see what's been used
before. The matching is case‑insensitive, and the suggestion it offers is cased
like the first value stored in the database, which nudges everyone toward one
consistent form.

A note on privacy: although its autocomplete route looks broadly accessible, the
module is careful. It only returns suggestions for fields that are actually
configured to use this widget, and it checks view access on a representative entity
(and on the field itself) for every candidate value before offering it, so it won't
surface values from content a user isn't allowed to see. One known limitation: it
does **not** work on the node title or other base fields — only on configurable
text fields. It depends on core's **Field** and **Text** modules. The current
release is a release candidate (2.0.0‑rc1), so test before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** — you switch a field to this widget on the
bundle's *Manage form display*, described below.

## Where it lives in the admin menu

The widget has no admin page of its own. You enable it per field under **Structure
→ Content types → *(your type)* → Manage form display**.

## How to use it

1. Go to any content type's (or other entity bundle's) **Manage form display**
   page — for example **Structure → Content types → Article → Manage form
   display**.
2. Find a supported text field and change its widget from **Textfield** to
   **Autocomplete: existing values**.
3. Click the widget's gear icon to configure **how many suggestions to show**
   (default **15**), then save.
4. Start entering values in that field as you create or edit content. Each value
   you save becomes a suggestion the next time someone types in the same field.

That's all there is to it — over time the field builds up its own list of
suggestions from real usage, keeping entries consistent without a vocabulary to
maintain.
