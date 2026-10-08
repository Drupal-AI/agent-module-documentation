# EPT Micromodal — manual setup guide

**EPT Micromodal** (`ept_micromodal`) adds a button-with-popup Paragraph type to
your site: a button that, when clicked, opens an accessible modal dialog. It's a
handy way to tuck away content that shouldn't take up room on the page until the
visitor asks for it — a privacy policy, a form, a short video, or any extra
detail behind a "Read more" or "Learn more" button. The modal behaviour comes
from the [Micromodal.js](https://micromodal.vercel.app/) library.

EPT Micromodal is one module in the **Extra Paragraph Types (EPT)** family. Every
EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
modal on the paragraph where you place it. The modal content is ordinary authored
content and renders through normal content handling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Modal paragraphs are
configured per instance, on the paragraph itself, using the shared EPT design
options described below.

## Where it lives in the admin menu

EPT Micromodal adds no admin settings page. Once enabled it registers a
Paragraph type for the button-and-modal component, listed under **Structure →
Paragraphs types** (`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Micromodal is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the Micromodal paragraph type.
2. Edit a piece of content, add the paragraph, set the button label, and author
   the content that appears inside the modal.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific instance.
4. Save. The button renders on the page; clicking it opens the modal.
