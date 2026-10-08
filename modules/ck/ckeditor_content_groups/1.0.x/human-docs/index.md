# CKEditor Content Groups — manual setup guide

**CKEditor Content Groups** (`ckeditor_content_groups`) adds three ways to group
content inside a CKEditor 5 rich‑text field: **accordions**, **horizontal tabs**,
and **vertical tabs**. Editors often need to present content in expandable
sections or tabbed panels — FAQs, product specifications, step‑by‑step guides,
layered documentation — and Drupal core's CKEditor 5 offers no built‑in way to do
this. The usual workarounds (presentational tables, block‑level modules that live
outside the text field, or custom JavaScript) are either semantically wrong,
inaccessible, or costly to maintain.

This module solves that by adding the widgets directly inside the editor. An
editor inserts a widget, then adds, removes, and reorders its items from an inline
contextual toolbar, and adjusts its behavior from a properties panel — all without
touching code or templates. The output is semantic, accessible markup
(`<details>`/`<summary>` for accordions, ARIA `tab`/`tabpanel` roles for tabs)
styled with plain CSS, so it does not depend on any CSS framework or theme. The
editor even injects the widget styles into the editing area, so content looks the
same while editing as it does once published.

The module is modular by design — each widget is an independent CKEditor 5 plugin,
so you enable only the ones you want per text format. It depends only on core
CKEditor 5. An optional submodule, **CKEditor Content Groups Schema**
(`ckeditor_content_groups_schema`), emits JSON‑LD structured data (FAQPage for
accordions, ItemList for tabs) to help search engines understand the content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the schema submodule.
2. [Configuration](configuration/index.md) — add the widget buttons to a text
   format and set their per‑format defaults.

## Where it lives in the admin menu

Content Groups has no standalone settings page. You enable and configure its
widgets per text format at **Administration → Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`), described in
[Configuration](configuration/index.md).
