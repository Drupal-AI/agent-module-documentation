# Layout Builder Block Headings — manual setup guide

**Layout Builder Block Headings** (`layout_builder_block_headings`) lets a
**block‑content type** designate one of its fields as the block's **heading**, then
renders that heading — with a configurable HTML level and CSS style class — when
the block is placed in a **Layout Builder** layout. It can optionally let editors
override the heading level and style per placement. The goal is better, more
consistent heading hierarchy: it improves accessibility (proper `h2`–`h6` nesting),
lifts design constraints, and keeps heading text managed on the block rather than
retyped at placement time.

Instead of relying on the core block "label" controls, the module hides them and
renders a real heading from a field on the block. The heading text is run through
Drupal's **text‑format** system (so you can allow a safe subset of HTML), the
level is constrained to a fixed whitelist of `h1`–`h6` (defaulting to `h2` if
anything invalid is chosen), and the style is applied as a sanitised CSS class —
so it is safe as well as flexible.

A candid note from the maintainer: this module is a work in progress and can be
"very opinionated with help text," and using it out of the box may not suit every
use case. It shines when you have a design system with a defined set of heading
levels and styles to plug in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The setup happens on your **block‑content type** and in **Layout Builder**, not on
a standalone settings form — so it is described in "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated settings page. You configure it on your **custom block
types** at **Structure → Block types** (`/admin/structure/block-content/types`),
and the per‑placement overrides appear inside **Layout Builder** — see
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder).

## How to use it

### 1. Add the fields to your block type

On a block‑content type, add (or reuse) the fields the heading behaviour draws
from:

- A **heading text** field. Consider making it *formatted* text so you can allow a
  few safe HTML tags — the [Allowed Formats](https://www.drupal.org/project/allowed_formats)
  module pairs well here for a safe editorial experience.
- A **heading level** field — a **text list (Options)** field whose allowed values
  are a subset of `h1`, `h2`, `h3`, `h4`, `h5`, `h6`. Pick values that make sense
  for your theme (it is rarely appropriate to let editors choose `h1`).
- A **heading style** field — a text list field whose options are the style
  classes from your design system.

### 2. Configure the block type

On the block type's edit form, under the module's **heading settings** (added by
the module), map:

- **Heading field** — the field whose value becomes the heading text.
- **Heading level field** — the field holding the default heading level.
- **Heading style field** — the field holding the default heading style.
- **Allow heading level customization** — let editors override the level per Layout
  Builder placement.
- **Allow heading style customization** — let editors override the style per
  placement.

On the block edit form, the level/style fields are wired to appear only once the
heading field has text.

### 3. Place and override in Layout Builder

When you add a reusable or inline block of that type to a Layout Builder layout, a
**Heading Settings** area appears (when customization is allowed), exposing an
override for the heading **level** (validated to `h1`–`h6`) and **style** (options
come from your style field). The heading text itself is shown disabled — it is
managed on the block, not at placement. The core block "label" controls are hidden
in favour of this managed heading.

The rendered heading uses the field's stored value and text format, the resolved
level, and the style as a sanitised CSS class. A theme suggestion,
`block__layout_builder_block_headings_block`, lets you override the template.
