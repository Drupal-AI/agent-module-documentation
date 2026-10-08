# DROWL Layouts — manual setup guide

**DROWL Layouts** (`drowl_layouts`) provides DROWL's default set of **ZURB
Foundation‑based layouts** for Drupal's Layout Builder and Layout Discovery. These
are responsive, column‑based section layouts — with real‑content previews (via
Twig Real Content) so sections look realistic while you build them — that editors
can pick when arranging a page. Each layout offers options such as column widths,
horizontal and vertical alignment (Foundation's `.align-*` classes), section
width (viewport width, page width, and so on), collapsing grid gutters per device
size, and extra CSS classes.

The module depends on core **Layout Discovery** and **Layout Builder**, plus
**Twig Real Content** for previews, and it provides a permission of its own. It is
a site‑building and theming feature: the layouts are used inside the normal Layout
Builder editing flow, gated by the usual layout/edit access, and the module adds
no access control beyond that.

Two things are worth knowing from the project's own notes. First, Foundation is
effectively end‑of‑life, so DROWL now recommends its Bootstrap successor,
[DROWL Layouts for Bootstrap](../../drowl_layouts_bs/1.0.x/human-docs/index.md),
for new sites. Second, this module leans on core issue
[#2904550](https://www.drupal.org/project/drupal/issues/2904550); until that is
fixed in core you may need that patch applied to keep config import/export working
when custom layouts live in a theme. You can also attach your own CSS/JS to the
Layout Paragraphs widget by defining a `YOURTHEME/drowl_layouts_layout_paragraphs_additions`
library in your theme — DROWL Layouts will find and attach it automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Layout Builder dependencies.

There is **no configuration page** for this module — the layouts appear directly
in the Layout Builder / Layout Paragraphs interface, as described below.

## Where it lives in the admin menu

DROWL Layouts adds no settings page. Its layouts show up wherever you choose a
section layout — in **Layout Builder** (on a content type's *Manage display*, or
when laying out an individual entity) and in Layout Paragraphs. Pick a DROWL
layout for a section and set its column, alignment, width, and gutter options
right there in the section configuration.
