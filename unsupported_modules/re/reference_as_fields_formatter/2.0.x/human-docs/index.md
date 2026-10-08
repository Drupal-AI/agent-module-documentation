# Entity Reference as fields formatter — manual setup guide

**Entity Reference as fields formatter** (machine name
`reference_as_fields_formatter`, project `reference_as_field`) is a display
formatter for **entity reference** fields. Instead of rendering a referenced
entity as a self‑contained nested block, it **merges the referenced entity's
individual fields into the host entity's render array** — so the referenced
content's fields appear inline, side by side with the host's own fields.

That flattening is useful whenever you want a referenced entity's data to read as
part of the parent rather than as a distinct embedded card: pulling a referenced
profile's fields inline on a page, laying a referenced "details" entity out among
the host's fields, and similar cases where a nested block would get in the way of
the design.

It has **no configuration UI of its own** — you set it up entirely on a field's
*Manage display*, like any other field formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the
   project name differs from the machine name) and enable the module.

There is **no configuration page** for this module. Setup happens on the entity
reference field's display, described under "How to use it".

## Where it lives in the admin menu

The formatter adds no admin page. You select it under **Structure → *(entity
type)* → Manage display**, on an entity reference field.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** tab of the entity type (and view mode) that has an
   **entity reference** field — for example **Structure → Content types → *(your
   type)* → Manage display**.
3. For that entity reference field, choose the **Entity Reference as fields**
   formatter.
4. Save. When the host entity is rendered, the referenced entity's fields now
   appear merged inline among the host's own fields, instead of as a nested block.
