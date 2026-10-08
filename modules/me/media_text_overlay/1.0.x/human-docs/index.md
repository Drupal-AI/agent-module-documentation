# Media Text Overlay — manual setup guide

**Media Text Overlay** (`media_text_overlay`) gives content editors a flexible way to
place **text on top of images** — hero banners, cards, captioned photos — without
touching a theme. You add overlay text to an image and position it, either by
choosing from a predefined **9-point grid** (top-left, center, bottom-right, and so
on) or by **dragging** the text freely to a custom spot. The overlay behaves
responsively so it holds up across screen sizes.

It builds on core **Image** and **Responsive Image**, and it aims to stay
lightweight and developer-friendly, so it is easy to extend for more advanced
layouts. The overlay text is ordinary content rendered over the image; the module
has no access-control role of its own — as with any editor-entered content, make
sure the text is output through appropriate, safe rendering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Image dependencies.

This module has **no dedicated settings page**. You set it up on a field's
*Manage display* (and enter the overlay text on the content form), as described
under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You configure the overlay on **Structure → Content
types → *(bundle)* → Manage display** (or the Manage display tab of any entity that
has a suitable image field).

## How to use it

1. On an entity that has an image field, open its **Manage display** tab.
2. Choose the **text overlay** formatter provided by this module for the image
   field.
3. In the formatter settings, set how the text is positioned — pick a spot on the
   **9-point grid** (top-left, center, bottom-right, etc.) or allow free
   drag-to-position — and any responsive options offered.
4. Enter the overlay/caption text on the content, and save. The text renders on top
   of the image at the chosen position.
