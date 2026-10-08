# CKEditor Tooltips — manual setup guide

**CKEditor Tooltips** (`ckeditor_tooltips`) adds a button to the CKEditor 5
toolbar that lets your editors attach a tooltip to any piece of text — or drop a
small "i" info icon — right inside the rich‑text editor. On the front end those
tooltips are powered by [Tippy.js](https://atomiks.github.io/tippyjs/), so
visitors get a polished pop‑up on hover, click, or focus. It's a natural fit for
inline glossary definitions, footnotes, or contextual help without cluttering the
page.

Setup happens in two places. First, you add the tooltip button to whichever text
formats should offer it, under **Text formats and editors** — this is normal
CKEditor 5 toolbar configuration. Second, an optional global settings form
controls how every tooltip looks and behaves: what triggers it (click, hover,
focus), its animation, maximum width, positioning offsets, and so on. The tooltip
content itself is stored right in the field's HTML as a `<span>` with a
`data-tippy-content` attribute, so it travels with the content and can be
translated per node.

The Tippy.js and Popper libraries are bundled with the module (no external CDN),
and the front‑end script loads on every page so tooltips render wherever the
content appears. The only dependency is core's **CKEditor 5** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the toolbar button to a text
   format, and tune the global tooltip settings field by field.

## Where it lives in the admin menu

Two locations. You enable the toolbar button per format under **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`). The global appearance/behaviour settings live
at **Configuration → Content authoring → CKEditor Tooltips**
(`/admin/config/content/ckeditor-tooltips`), gated by the *Administer CKEditor
tooltips* permission (`administer ckeditor tooltips`).

## How to use it

Once the button is on a format, editors select a word or phrase, click the
tooltip icon, and type the tooltip content in the popup (or click with nothing
selected to insert a default "i" icon). Save the content and the tooltip appears
on the front end according to your global settings. The full walkthrough is in
[Configuration](configuration/index.md).
