# Nested Entity Reference Formatter — manual setup guide

**Nested Entity Reference Formatter** (`nested_entity_reference_formatter`) adds a
configurable field formatter for entity-reference fields that can render a **nested
field** of the referenced entity, rather than the whole target. Using an AJAX-driven
configuration form, you pick a field on the referenced entity — or on *its* own
references, and so on to any depth — and choose which formatter should render that
deep value. The result is that a reference field can display exactly the piece of
related data you want.

A concrete example: imagine taxonomy terms that carry fields such as a weight, a
description, an image, or further entity references. Instead of rendering the whole
referenced term, this formatter lets you reach in and display just the term's
image, or its description, or a value from an entity it in turn references — each
with the formatter appropriate to that field. It supports **unlimited nesting**
levels and works with custom entities and fields, which makes it a flexible way to
present multi-level relationships cleanly.

It is purely a **content-display** feature. It has no configuration page, no
permissions, and no access-control role of its own: referenced entities and fields
are rendered respecting their own access, so only targets and fields the viewer may
see will appear. The module depends on Drupal core only and runs on Drupal 8.8
through 11. Note that it is **minimally maintained** (maintenance fixes only).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. All setup happens on a field's
**Manage display** screen, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You use it entirely from **Field UI →
Manage display** for whichever entity type and bundle holds your entity-reference
field — for example **Structure → Content types → *(type)* → Manage display**.

## How to use it

1. Make sure you have an **entity-reference field** (to a node, taxonomy term,
   media item, or any entity) on the bundle you want to display.
2. Go to that bundle's **Manage display** screen (for a content type: **Structure
   → Content types → *(type)* → Manage display**).
3. For your reference field, change the **Format** to the Nested Entity Reference
   Formatter.
4. Open the format's settings (the gear icon). Using the AJAX-driven controls,
   choose the **nested field** on the referenced entity you want to display, then
   pick the **formatter** for that field. If the nested field is itself a
   reference, you can keep drilling down to reach a deeper value.
5. Click **Update**, then **Save**. The field now renders the chosen nested value
   instead of the whole referenced entity.
