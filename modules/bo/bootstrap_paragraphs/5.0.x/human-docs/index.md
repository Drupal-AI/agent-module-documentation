# Bootstrap Paragraphs — manual setup guide

**Bootstrap Paragraphs** (`bootstrap_paragraphs`) gives you a ready‑made suite of
about fifteen **Paragraph types**, built for the Bootstrap 5 CSS framework, so you
get a structured page‑builder without hand‑crafting paragraph types yourself. Out
of the box you get a Simple rich‑text block, an Image block, multi‑column layouts
(equal and uneven), an Accordion, a Carousel, Tabs, a Modal, a "Drupal Block"
embed, and a "View" embed — the building blocks editors assemble into landing
pages.

It's worth understanding what this module *is*: it's a **configuration and Twig
package**, not code. It contains no PHP classes, services, routes, or permissions —
just the paragraph‑type definitions, their fields, form/display setups, and the
Twig templates and CSS/JS that turn each block's settings into Bootstrap classes.
Once installed, all of it becomes ordinary site configuration that you're free to
edit, extend, or export like anything else on your site.

Nearly every bundle carries the same four **shared "Styles" fields**, grouped into
a collapsible section on the edit form: a **background** colour (Bootstrap brand
colours plus a large palette of translucent tints), a **width** (tiny through
full‑screen), and **margin** and **padding** (small/medium/large, top and/or
bottom). That gives editors consistent control over section styling without
touching CSS. Container bundles (Columns, Carousel, Accordion, Tabs, Modal) nest
other paragraphs inside them, with sensible allow‑lists so, for example, an
Accordion only accepts Accordion Sections.

There is **no settings page** (`configure: null`) — the module simply installs the
bundles, and from there you wire them into your content types like any Paragraphs
setup. Because of that, this guide has no separate configuration page; the "How to
use it" section below covers the setup you do have to perform.

> **Your theme must provide Bootstrap 5.** The module ships only its own component
> CSS/JS; the underlying Bootstrap framework has to come from your theme (or a CDN
> include). Without it, the layouts won't look right.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the several
   dependencies), enable the module, and pick the optional submodules.

## Where it lives in the admin menu

Bootstrap Paragraphs adds **no settings page**. After install you'll find the new
paragraph types at **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`), and you configure everything else on your own
content types' **Manage fields / form display / display** screens.

## How to use it

The module installs the bundles but does **not** attach them to any content type —
that part is up to you.

### 1. Confirm the bundles installed

Visit **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) and
check you see the `bp_*` types (Simple, Image, Columns, Accordion, and so on).
Because the configuration is "optional", a bundle only installs if its
dependencies are present.

### 2. Add a Paragraphs field to your content type

On the content type you want to build pages with (say *Page*), add a field of type
**Paragraph** (an entity reference revisions field), usually with **unlimited**
cardinality. In the field's settings, choose which `bp_*` bundles editors may add.

> **Don't** offer **Accordion Section** or **Tab Section** on a top‑level field —
> those are children that only belong inside an Accordion or Tabs bundle.

### 3. Choose text formats on Simple and Blank

The module ships no opinion about text formats. On the **Simple** bundle, set the
text field to the format you want (commonly *Full HTML*); the **Blank** bundle is
designed for a no‑editor Full‑HTML format so a trusted editor can paste raw markup.

### 4. Style per section

There are deliberately **no default margins or paddings** — editors set them per
section using the **Styles** field group (background, width, margin, padding) on
each paragraph. This keeps spacing intentional rather than baked in.

### 5. Extend or override

Add extra brand colours by defining the corresponding classes in your theme's CSS,
and override any bundle's markup by copying its Twig template (for example
`paragraph--bp-image.html.twig`) into your theme. You can also export the installed
`bp_*` config into your own config sync directory and treat it as fully
site‑owned.
