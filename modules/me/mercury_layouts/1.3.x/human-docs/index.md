# Mercury Layouts — manual setup guide

**Mercury Layouts** (`mercury_layouts`) provides a set of composable, responsive
**layouts** intended for — but not limited to — the
[Mercury Editor](https://www.drupal.org/project/mercury_editor) drag‑and‑drop page
builder. It gives content editors a palette of nestable sections (stacks, columns,
clusters) that they can arrange within Mercury Editor to compose landing pages and
rich content without writing any code.

The layouts are built with core's **Layout Discovery** API and the
[Single Directory Components](https://www.drupal.org/docs/develop/creating-modules/single-directory-components)
(SDC) approach, which means the underlying components can be reused in any Twig
template regardless of your theme — they are not locked to Layout Builder or Layout
Paragraphs. Each layout exposes configurable **style options** (via the
[Style Options](https://www.drupal.org/project/style_options) module), so editors
can tune spacing, alignment, and similar settings per section. The design concepts
are drawn from [Every Layout](https://every-layout.dev/), a well‑regarded resource
on building accessible layouts with modern CSS.

The included layouts are **Mercury Stack**, **Mercury Two Columns**, and **Mercury
Cluster** (with three‑ and four‑column variants noted as coming soon). It depends on
core's **Layout Discovery** and the **Style Options** module (≥ 1.1.0), and needs
Drupal 10.3 or 11. This is a presentation / site‑building module — it defines
structure and styling, not access control — and it expects Mercury Editor to be
present to consume the layouts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Style Options and Mercury Editor.

There is **no configuration page** — Mercury Layouts has no settings form. The
layouts it provides appear as options wherever layouts are chosen (most commonly in
Mercury Editor); their per‑section style options are set on each section as you build
a page.

## How to use it

Once enabled, the Mercury layouts become available in your page‑building UI. In
Mercury Editor, add a section and pick one of the Mercury layouts (Stack, Two
Columns, Cluster). Place your content into the layout's regions, and use the
**style options** on the section to adjust its appearance. Because the layouts are
plain Layout Discovery plugins backed by SDC components, developers can also use the
same components directly in Twig templates.
