# Area Print — manual setup guide

**Area Print** (`area_print`) lets a visitor print **one chosen part of a page** —
a single article, a table, a receipt — instead of the whole document. It attaches
a print control to a defined area and, when triggered, sends just that area's
markup to the browser's print dialog.

The standard way to control printing is a print stylesheet (`@media print`), and
that remains the right tool for deciding *how* a page looks on paper. What a
stylesheet does not do easily is let a visitor print *one region on demand*, since
`@media print` applies globally. Area Print takes the JavaScript route instead: it
provides a render element and a plugin, plus a small JavaScript library, so a
print button can be wired to a specific region and clicked by the visitor.

Two things are worth knowing before you rely on it. First, **you should still have
a print stylesheet** — this module chooses *what* gets sent to the print dialog,
but a `@media print` stylesheet governs *how it looks* (margins, colours, page
breaks, link URLs); without one, the printed output will be poor no matter what is
selected. Second, **JavaScript‑driven printing behaves differently across
browsers**, so test the result in the browsers your audience actually uses. It has
no dependencies beyond core and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Area Print has no settings page. It works by attaching its print control and
library to a defined area of a page — through the render element and plugin it
provides — so that a "print this section" control appears next to that content.
You set this up in your theme or in the render arrays where the printable region
is built. Pair it with a `@media print` stylesheet so the selected content is
styled properly on paper, and check the printed result across the browsers your
visitors use. Note this is a **beta release** (2.0.0‑beta4).

If a page has exactly one printable region, a plain print stylesheet that hides
everything else may be all you need and this module is unnecessary. For a fully
paginated, styled document, a PDF generator is usually the better tool — Area
Print is the lightweight, print‑a‑section option.
