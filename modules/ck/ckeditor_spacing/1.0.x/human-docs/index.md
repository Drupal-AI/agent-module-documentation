# CKEditor Spacing — manual setup guide

**CKEditor Spacing** (`ckeditor_spacing`) gives content editors a small, safe
control for setting **margin and padding on individual blocks** — paragraphs,
headings, lists, blockquotes, images, tables — straight from a balloon in
CKEditor 5. Editors type the number they want and pick a unit (px, rem, em, %,
vw, or vh); the block gains a harmless data attribute, and a text-format filter
turns that into CSS when the page is rendered.

The problem it solves is a familiar one. Every so often a single paragraph needs
a little more room to breathe, or a heading sits too close to the text above it
in one place only. The tempting fix is to enable the `style` attribute on the
text format so editors can type inline CSS by hand — but that lets anyone who can
edit content paste arbitrary CSS, a real risk on any multi-author site. CKEditor
Spacing never enables the `style` attribute: spacing is stored as controlled data
attributes and validated by the same grammar in both JavaScript and PHP
(negatives, `calc()`, unknown units, and injection attempts are rejected
server-side), so a restricted text format stays restricted. It is also
right-to-left aware, emitting logical CSS properties so spacing flips correctly
in RTL languages.

This module has **no separate configuration page** and adds no content type.
Everything is set up per text format, and setup takes two steps that both matter:
you add the **Spacing** toolbar button, and you enable (and correctly order) the
**"Apply spacing to block elements"** filter. If you skip the filter step, the
editor will look like it works but published pages will show no spacing. It
depends only on core's CKEditor 5 module, has no third-party libraries, and no
build step.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-text-format setup (toolbar
   button, filter, and the units offered to editors), step by step.

## Where it lives in the admin menu

CKEditor Spacing has no settings page of its own. You enable and tune it per text
format at **Administration → Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). See
[Configuration](configuration/index.md) for the exact steps.

## How editors use it

Once the button and filter are in place, an editor puts the caret in (or selects)
a block, clicks **Spacing** in the toolbar, and enters margin and padding values
with the unit they want. Spacing previews live as they type, and **Cancel**
restores whatever the block had when the balloon opened. When the caret is inside
a block that already has spacing, a small actions balloon appears — much like the
one for links — summarising what is applied, with edit and clear buttons. Corner
markers appear around a spaced block on hover and while editing, so editors can
see the effect without clicking; those markers are editor-only and never saved.
