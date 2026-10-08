# Paragraphs Inline Entity Form — manual setup guide

**Paragraphs Inline Entity Form** (`paragraphs_inline_entity_form`) lets editors
create and embed **Paragraphs** entities directly inside a CKEditor 5 rich‑text
body. It wires together four contrib systems — Entity Embed, Entity Browser,
Inline Entity Form, and Paragraphs — so a paragraph (an image, a gallery, an embed
card, a layout block) can be dropped into running text with almost no custom code.

In practice, editors get a **Paragraphs** button on the CKEditor 5 toolbar. Click
it and a two‑step flow opens: first a grid of paragraph‑type icons to pick the
kind of paragraph, then an inline form to fill in that paragraph's fields. Once
embedded, the paragraph can be edited again from the embed dialog, and the editor
sees a live preview. It's a config‑only, lower‑code alternative to writing your own
embed integration.

This module is almost entirely configuration plus a small amount of glue code. It
has **no settings page of its own** and **no permissions of its own** — what an
editor can embed is governed by the embed button's allowed bundles, the text
format, and the Entity Browser *Access Paragraph items pages* permission plus the
underlying Entity Embed / Paragraphs access. Because it stitches several modules
together, it has a fairly long dependency list (see
[Installation](installation/index.md)). A bundled example submodule gives you a
working demo to evaluate the workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and (optionally) the example submodule.

## Where it lives in the admin menu

There's no dedicated settings page. Setup happens on two existing core admin
pages: the **Embed buttons** page (**Configuration → Content authoring → Embed
buttons**, `/admin/config/content/embed`) and the **Text formats and editors**
page (**Configuration → Content authoring → Text formats and editors**,
`/admin/config/content/formats`).

## How to use it

When you enable the module, it installs two ready‑made pieces of configuration: a
**Paragraphs** embed button and a **paragraph_items** entity browser. You then do
three manual steps to make them usable:

1. **Choose which paragraph types are embeddable.** Go to
   `/admin/config/content/embed`, edit the **Paragraphs** embed button, and select
   the allowed paragraph bundles. The button ships with no bundles selected (which
   means all types are offered) — pick the ones you want.
2. **Add the button to a text format.** Go to
   `/admin/config/content/formats` and edit the CKEditor 5 text format you want to
   use it in:
   - Drag the **Paragraphs** embed button onto the toolbar.
   - Enable the **Display embedded entities** filter.
   - Make sure the `<drupal-entity>` markup (and its `data-*` attributes) is
     allowed in **Allowed HTML tags**. If unsure, copy the allowed‑tags list from
     the example module's text format.
3. **Grant the permission.** At `/admin/people/permissions`, give every role that
   edits content **Access Paragraph items pages**
   (`access paragraph_items entity browser pages`) and the *Use the … text format*
   permission for the format you configured. Skipping this makes the dialog open on
   an **Access denied** page instead of the paragraph‑type picker.

After that, editors using that text format will see the **Paragraphs** button and
can embed paragraphs inline. You can set up several embed buttons and formats, each
scoped to a different set of paragraph types.

To explore the feature quickly, enable the **example submodule**
(`paragraphs_inline_entity_form_example`), which provides a demo content type and
paragraph types already wired up.

## Troubleshooting

- **"Access denied" in the dialog** — the role is missing *Access Paragraph items
  pages* (step 3).
- **The embedded paragraph disappears when you save or view the content** — the
  `<drupal-entity>` tag is being stripped by the text format; add it to the
  allowed HTML tags (step 2).
- **Nothing happens when you click the toolbar button** — check that *Display
  embedded entities* is enabled and that the button is on the same format the
  field uses.
