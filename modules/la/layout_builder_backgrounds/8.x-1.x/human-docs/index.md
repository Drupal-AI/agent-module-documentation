# Layout Builder Backgrounds — manual setup guide

**Layout Builder Backgrounds** (`layout_builder_backgrounds`) lets an editor set a
**background image or colour** on any **Layout Builder** section. It is the first
thing most people ask for after enabling Layout Builder, and core does not provide
it: sections have a layout and a set of blocks, but no notion of how the band
*behind* them looks. Without this you would need a layout plugin per background
variant, a class field editors type into, or a theme that infers the background
from position. Attaching the background to the section itself is the right place —
a background belongs to the band, not to anything inside it.

Unlike some alternatives, it does **not** require modifying your existing layouts,
so it works out of the box with custom layouts or layouts from other modules (such
as Bootstrap Layouts). Its dependency list tells you the architecture: style
options come from **Layout Builder Styles**' vocabulary of classes, and background
images come from the **media library** rather than a bare file field — so
background images are managed assets with alt text, reuse, and access control.

Three things are worth checking on any background feature:

1. **Contrast is the accessibility question.** Text over a photograph or a
   mid‑tone colour frequently fails the 4.5:1 requirement, and nothing in the UI
   warns the editor — so a background chooser can break contrast one page at a
   time unless your palette is constrained.
2. **A background image is a page‑weight decision.** A full‑bleed photograph is
   often the largest asset on the page and the one blocking Largest Contentful
   Paint, so serve it through responsive image styles rather than the original.
3. **Decorative backgrounds must not carry meaning.** A background image is not
   announced to a screen reader, so any information it conveys must also exist as
   text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with Layout Builder Styles and the media dependencies).

This module has no separate settings form — backgrounds are set per section inside
Layout Builder. See "How to use it".

## Where it lives in the admin menu

Layout Builder Backgrounds adds no admin settings page. You set backgrounds inside
**Layout Builder**, on a section's configuration — see
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder) and the
[Layout Builder Styles](https://www.drupal.org/project/layout_builder_styles)
module, whose class vocabulary supplies the style options.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Edit a layout in **Layout Builder** (for example **Structure → Content types →
   *(type)* → Manage display** with Layout Builder enabled, or a per‑entity
   layout).
3. **Add** or **configure a section**. In the section's settings you can now set a
   **background colour** and/or choose a **background image** from the media
   library, in addition to the class‑based styles that Layout Builder Styles
   provides.
4. Add blocks to the section and **Save the layout**. Keep the contrast,
   page‑weight, and accessibility points above in mind as you pick backgrounds.
