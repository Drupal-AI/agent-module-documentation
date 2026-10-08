# CKEditor BiDi Buttons — manual setup guide

**CKEditor BiDi Buttons** (`ckeditor_bidi`) adds a **text‑direction** button to the
CKEditor 5 toolbar, letting editors set whether a block of text runs **right‑to‑left
(RTL)** or **left‑to‑right (LTR)**. That's essential for bi‑directional content — an
English quotation inside an Arabic article, a Hebrew paragraph in an otherwise
left‑to‑right page, and so on. The button writes the standard HTML `dir` attribute onto
the block you're editing (a paragraph, heading, list item, table cell, and the like), and
declares those attributes as allowed so they survive Drupal's text filtering.

The module ships a single CKEditor 5 plugin with one toolbar item and one optional
setting, and it depends on core's **CKEditor 5** module. There is no central admin page —
you configure it **per text format**, by dragging the Direction button into that format's
toolbar. Everything is stored on the format's editor configuration, so it can be exported
and deployed like any other config.

The one setting worth understanding is **"Never remove direction, only switch"**. By
default, clicking a direction button that matches the editor's own default direction
*removes* the `dir` attribute to keep the HTML clean — but that means you can't force,
say, `dir="ltr"` on content authored in an LTR admin, so it may inherit the wrong
direction when later shown on an RTL page. Turning the setting on makes the buttons always
set an explicit direction and never strip it, which guarantees correct rendering across
mixed‑direction contexts (and in email clients that default to LTR).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no module settings page. You add and configure the button under
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on any format whose editor is CKEditor 5.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors** and edit a
   format that uses **CKEditor 5**.
3. In **Toolbar configuration**, drag the **Direction** button from *Available* into
   *Active*.
4. If the button's settings appear (once it's in the toolbar), decide whether to tick
   **"Never remove direction, only switch"**:
   - **Off (default):** cleaner HTML, but a direction that matches the editor default is
     stripped rather than forced.
   - **On:** the buttons always write an explicit `dir="ltr"` / `dir="rtl"` — use this
     when content is viewed across mixed LTR/RTL contexts.
5. Save the format.

Editors using that format now get RTL/LTR buttons and can set the direction of any block
without editing source HTML. The setting is inert unless the Direction button is actually
in the toolbar and the format's editor is CKEditor 5.
