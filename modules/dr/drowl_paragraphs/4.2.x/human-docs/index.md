# DROWL Paragraphs — manual setup guide

**DROWL Paragraphs** (`drowl_paragraphs`) is a collection of Paragraphs
enhancements from the DROWL agency that turn Drupal's Paragraphs into a more
flexible, powerful page‑building toolkit. Its centrepiece is a reusable
**"DROWL Paragraph Settings"** field: add it to a paragraph type and each
paragraph instance gains a set of display options — grid settings (ZURB
Foundation XY‑grid), animations (Animate.css), paddings and margins,
background images (including a parallax effect), and more. Alongside it, a
site‑wide **settings form** stores sensible defaults (notably for slideshow
paragraphs), and a family of submodules ship ready‑made paragraph types so
editors have building blocks to work with immediately.

Be prepared for some setup, and be honest with yourself about the fit. The
project's own page is candid: in its current state DROWL Paragraphs needs
**a fair amount of manual configuration** to bring everything to life, and it was
designed to pair with DROWL's own Foundation‑6.x‑based theme — it ships **no CSS**
of its own, so options like "Box Styles" only come alive once you add the matching
styles (DROWL publishes a companion SASS base, `drowl-sass-base`, on npm). You
also create your own "Container" paragraph types to nest other paragraphs inside.
For new, Bootstrap‑based sites, DROWL now points people at its successor,
[DROWL Paragraphs for Bootstrap](../../drowl_paragraphs_bs/4.2.x/human-docs/index.md).

Under the hood it builds on **Paragraphs**, **Layout Paragraphs**, **Field
Group**, **Foundation Sites**, and
[DROWL Layouts](../../drowl_layouts/4.2.x/human-docs/index.md), plus **Twig
Tweak**, **Responsive Background Image**, and core **Breakpoint** and **Field**.
The single admin route is its settings form, gated by one restricted‑access
permission; there are no anonymous, mutating, or callback endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the paragraph‑type submodules you want.
2. [Configuration](configuration/index.md) — the site‑wide settings form (mainly
   slideshow defaults), field by field.

## Where it lives in the admin menu

The site‑wide settings form sits at **Configuration → System → DROWL Paragraphs**
(`/admin/config/system/drowl-paragraphs`). Everything else happens where you build
content: you add the **DROWL Paragraph Settings** field and the DROWL paragraph
types to your paragraph bundles under **Structure → Paragraphs types**, and you
lay pages out with Layout Paragraphs.
