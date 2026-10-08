# Field Image Tooltips — manual setup guide

**Field Image Tooltips** (`field_image_tooltips`) lets you present an image that
carries interactive **tooltips (hotspots)** — clickable markers placed on the
image that, when triggered, load a referenced node's rendered content into a
**modal dialog**. It's built for interactive infographics, annotated product
photos, image maps for education or e‑commerce, and similar "click the picture
to learn more" experiences, all without duplicating content: each hotspot points
at an existing node.

The module is built on [Paragraphs](https://www.drupal.org/project/paragraphs).
It provides a ready‑to‑use Paragraph bundle for the image‑with‑tooltips setup,
and ships a bundled submodule, **Field Tooltips Data** (`field_tooltips_data`),
that supplies the underlying field type, widget, and formatter for the tooltip
data (which node each hotspot references and where it sits on the image). The
tooltip content is fetched over AJAX and shown in the modal; there's a no‑JS
fallback as well.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Paragraphs dependency, and enable the bundled Field Tooltips
   Data submodule.

There is **no dedicated configuration page** for this module — it has no central
settings form. You set it up on your entity's fields and the Paragraph bundle,
described in "How to use it" below.

## Where it lives in the admin menu

Field Image Tooltips adds no top‑level admin page. You work with it through the
usual Field UI: **Structure → Content types → *(your type)* → Manage fields**
(to add the Paragraphs field to your content), and **Structure → Paragraph
types → Image with tooltips → Manage fields** (to adjust the bundled tooltip
fields).

## How to use it

1. Add a **Paragraphs** field to the content type (or other entity) where you
   want the interactive image — for example on Article, using the *Manage
   fields* interface, with the **Embedded** (paragraphs) widget.
2. In that field's configuration, under **Allowed Paragraph bundles**, choose
   **Image with tooltips**. Set the **Default edit mode** to *Open* and the
   **Add mode** to *Buttons*.
3. Optionally, adjust the default fields of the **Image with tooltips**
   Paragraph bundle at **Structure → Paragraph types → Image with tooltips →
   Manage fields**.
4. When editing content, upload your image, then use the bundled tooltip widget
   to place tooltip markers and reference the node each one should open.
5. On the front end, the default formatter renders the image with its tooltip
   markers; clicking a marker opens the referenced node's content in a modal.

The referenced nodes stay ordinary, editable, translatable nodes — the tooltips
reuse their display, so nothing is duplicated.
