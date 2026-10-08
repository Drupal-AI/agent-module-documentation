# Graupl Paragraphs — manual setup guide

**Graupl Paragraphs** (`graupl_paragraphs`) provides a set of **paragraph
behaviors** for the **Graupl** front-end framework. Behaviors are the plugins
Paragraphs uses to add extra controls to a paragraph — here, layout and styling
options that let you build pages with Graupl using the Paragraphs module.

If you build pages out of paragraphs and want Graupl's layout/styling conventions
available on them, this module adds those controls as paragraph behaviors. It is
a site-building and theming aid: the behaviors add configuration to paragraphs
and the module has no content model or access-control role of its own.

As with the rest of the Graupl suite, this module is at a **very early stage** of
development. Its maintainers do not recommend it for production sites until a
stable release is made, so evaluate it accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Paragraphs.

There is **no central configuration page** for this module. The behaviors are
enabled and configured per paragraph type, described below.

## How to use it

Graupl paragraph behaviors are turned on per **paragraph type**:

1. Go to **Structure → Paragraph types** and edit the paragraph type you want to
   extend.
2. In the paragraph type's **Behaviors** section, enable the Graupl behavior(s)
   this module provides and set their layout/styling options.
3. When an editor adds a paragraph of that type, the Graupl behavior's controls
   appear on the paragraph, letting them apply the layout/styling.

There is no separate settings form to visit first — everything happens on the
paragraph type's edit form.
