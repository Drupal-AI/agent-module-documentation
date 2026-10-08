# Markup — manual setup guide

**Markup** (`markup`) adds a `markup` field type whose job is to output a fixed
block of HTML you define once, rather than a value each editor types in. You set
the markup in the field's settings, and every entity of that bundle then shows
the same block — both on the entity's **edit form** (via the field's widget) and
on the entity's **display** (via its formatter).

Think of it as the point‑and‑click equivalent of adding a `#markup` element to a
form: a way to drop standing instructions, notices, dividers, call‑to‑action
buttons, legal boilerplate, or an embedded third‑party snippet into a content
type without writing a custom `hook_form_alter`. Because the markup lives in the
field configuration, it is exported with your config and stays consistent across
deployments.

The module registers a matching set of Field API plugins — a `markup` field
type, `markup` widget, and `markup` formatter — and depends only on core's Field
module. It has **no admin settings page, no permissions, and no configuration UI
of its own**; all setup happens in the per‑field settings when you add the field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Markup adds nothing to the admin menu. You use it through Field UI on any
fieldable entity, for example **Structure → Content types → (your type) → Manage
fields** (`/admin/structure/types/manage/{type}/fields`).

## How to use it

1. On a bundle's **Manage fields** screen, click **Add field** and choose
   **Markup**.
2. On the field settings step, fill in the **Markup** element — a rich‑text box
   with a text‑format selector. Type your HTML and pick a text format (for
   example *Full HTML*); this value is required. Whatever you enter is what every
   entity of the bundle will show.
3. Save. The field is always single‑value — the module removes the "number of
   values" selector, so a Markup field is always cardinality 1.

A few things worth knowing:

- The **widget** renders your markup on the entity **edit form**, so authors see
  it while editing. Keep the widget enabled under **Manage form display** for
  that.
- The **formatter** renders the same markup on the entity **display**. To show
  the markup to editors only (not to visitors), set the field to hidden under
  **Manage display** while keeping the widget under **Manage form display**.
- Because the markup is a field *setting*, you change it by editing the field —
  not by editing content.
- Only the HTML allowed by the chosen text format is emitted. The settings form
  suggests wrapping visible output in a `<div class="form-item">…</div>` to
  follow form standards and avoid breaking page layout.
