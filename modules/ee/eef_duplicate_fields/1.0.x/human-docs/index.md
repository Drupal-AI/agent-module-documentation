# EEF - Duplicate Fields — manual setup guide

**EEF - Duplicate Fields** (`eef_duplicate_fields`) extends the
[Entity Extra Field](https://www.drupal.org/project/entity_extra_field) module with
two extra-field plugins that let site builders surface field data on an entity's
display in ways that would otherwise need custom code — all from the **Manage
display** UI.

The two plugins are:

- **Duplicate Field** — creates a virtual copy of any existing field on the same
  entity, rendered with a completely independent formatter configuration. Use it to
  show the same image at two different sizes, a date in two formats, or a body
  field with different truncation — without adding redundant fields to your content
  model.
- **Referenced Entity Field** — renders fields from a *referenced* entity directly
  in the parent entity's display, with optional single-level chaining through a
  second entity reference. For example, pull a branch's phone number onto an event,
  or chain Event → Branch → Branch Address.

Both plugins respect field access permissions, handle multi-value references, and
propagate cache metadata correctly. The module depends on **Entity Extra Field**
and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Entity Extra Field dependency.

There is **no standalone settings page** for this module. You add and configure its
extra fields on an entity's **Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You use it from **Structure → Content types
→ (type) → Manage display** (or the Manage display of any fieldable entity), where
Entity Extra Field's "Add extra field" workflow now offers the Duplicate Field and
Referenced Entity Field plugins.

## How to use it

1. On the bundle's **Manage display**, use Entity Extra Field to add a new extra
   field.
2. Choose one of this module's plugins:
   - **Duplicate Field** — select the source field to copy, then configure the
     formatter you want for this copy (independent of the original's formatter).
   - **Referenced Entity Field** — select the entity-reference field to follow and
     the field on the referenced entity to render; optionally chain through a
     second reference to reach a field one more level away.
3. Position the extra field in the display and save. It now renders on that view
   mode alongside the entity's real fields.
