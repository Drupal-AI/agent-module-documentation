# Text Overlay Image — manual setup guide

**Text Overlay Image** (`text_overlay_image`) is a simple block that displays
text laid over a background image — the kind of hero or banner you often want at
the top of a landing page. When you place the block you can upload a background
image, add your own text, and adjust the opacity of a colour layer behind the
text, so the words stay readable against the picture.

It is a small, focused content-display module: one block plugin, configured per
placement, with core's **Block** module as its only dependency. The text is
supplied by an administrator or editor when configuring the block, and rendered
over the image. It has no role in access control.

Text Overlay Image runs on Drupal 9, 10 and 11. It is listed as minimally
maintained (maintenance fixes only).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module does not add a central settings page — you configure each banner
where you place the block:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place a block in the region where you
   want the banner.
3. Choose the **Text Overlay Image** block, then in its configuration:
   - **upload a background image**,
   - **add the text** to display over it, and
   - **set the background-colour opacity** to control how strongly the overlay
     tints the image behind the text.
4. Save and position the block. It renders your text over the image on the front
   end.

Because the text is rendered over the image, keep in mind that it is
administrator/editor-supplied content, so only trusted roles should be granted
the ability to place and configure blocks.
