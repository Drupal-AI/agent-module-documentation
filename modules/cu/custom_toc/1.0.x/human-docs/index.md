# Custom TOC — manual setup guide

**Custom TOC** (`custom_toc`) adds a **Table of Contents** field to your content —
a field type, a widget, and a formatter working together — that builds a navigable
TOC from the headings in a rich-text (CKEditor) field. Editors click a button to
generate a starter table of contents from a chosen source field, then refine the
link text of individual entries. The generated markup is **stored** on the field,
and the formatter renders that saved value, so the published TOC stays stable and
matches exactly what the editor approved — even across different view modes.

This is handy for long articles, documentation pages, or policy content where
readers benefit from jump links to each section. Because the TOC is editable
per node, authors keep control over the wording without touching template code.
Custom TOC depends on the **TOC API** module (`toc_api`), which handles the
underlying heading extraction and TOC "type" settings, and it supports Drupal 10
and 11.

Custom TOC has **no global settings page**. All of its configuration happens on a
field: you add the TOC field to a content type and set it up on the *Manage form
display* and *Manage display* screens, described in "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its `toc_api`
   dependency, and enable them.

There is **no configuration page** for this module — it has no settings form. The
setup happens on your content type's fields and display, described below.

## Where it lives in the admin menu

Custom TOC adds no admin settings page of its own. You configure it on your content
type at **Structure → Content types → *(your type)* → Manage fields / Manage form
display / Manage display**. The related heading and template options come from the
**TOC API** module's *TOC type* settings.

## How to use it

1. Enable the module and its `toc_api` dependency (see
   [Installation](installation/index.md)).
2. On a content type, add the **TOC (CKEditor)** field (**Structure → Content
   types → *(your type)* → Manage fields**).
3. In the field's settings, **choose the source field** for heading extraction —
   this must be a formatted (rich-text) field with text processing enabled — and
   set the **allowed text formats** and a **default format**.
4. Configure the **TOC API "TOC type"** settings (which heading levels to include
   and the TOC template) to taste.
5. When creating or editing content, add your headings in the source field, click
   **Regenerate TOC** to build the initial markup, optionally edit the TOC entry
   text, then save the node. The formatter renders the saved TOC on the page.

> **Tip:** Avoid enabling the `toc_api_example` submodule, as it can change heading
> IDs on view, which may throw off the anchors your saved TOC links to.
