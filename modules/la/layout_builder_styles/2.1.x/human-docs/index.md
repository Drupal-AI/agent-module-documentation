# Layout Builder Styles — manual setup guide

**Layout Builder Styles** (`layout_builder_styles`) lets you define reusable sets
of CSS classes and expose them as friendly, selectable "styles" on the blocks and
sections editors build in Layout Builder. The result: content authors can restyle
a layout — a background color, some spacing, a "boxed" section, a card variant —
by picking from a dropdown, without touching CSS or the theme.

You define each **style** in the admin UI: give it a label, list the CSS class or
classes it applies, and say whether it targets *blocks* or *layout sections*. You
can even restrict a style so it only appears for certain block plugins or certain
layouts. Related styles can be bundled into **style groups**, which control how
the choices are presented — a single‑select dropdown, radios, or multi‑select
checkboxes — and whether a selection is required. When an editor adds or
configures a block or section in Layout Builder, your style selectors appear
right in that form, and the chosen classes are attached to the rendered output
(with matching theme hook suggestions so themers can template styled blocks).

Because styles and groups are stored as **configuration**, they export and deploy
cleanly between environments — which makes this the standard way to give a design
system's utility classes a curated, editor‑safe UI inside Layout Builder while
keeping real markup control in the theme. The module depends only on core's
Layout Builder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage styles and style
   groups, field by field.

## Where it lives in the admin menu

Once enabled, manage your styles at **Configuration → Content authoring → Layout
builder styles** (`/admin/config/content/layout_builder_style`). The styles you
define there then show up automatically inside the Layout Builder editing UI when
an editor adds or configures a block or section.

## How to use it

The typical workflow is: define your styles once, then let editors use them
everywhere.

1. Go to **Configuration → Content authoring → Layout builder styles** and create
   the styles (and, optionally, groups) you want — see
   [Configuration](configuration/index.md).
2. Edit any layout via Layout Builder. When you add or configure a block or
   section, the style selectors you defined appear in that form.
3. Pick the styles you want; the associated CSS classes are applied to the
   rendered block or section on the live page.

Managing styles requires the **Manage layout builder styles** permission; the
selectors then appear to anyone who can edit the layout.
