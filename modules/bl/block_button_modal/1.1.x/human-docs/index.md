# Block Button Modal — manual setup guide

**Block Button Modal** (`block_button_modal`) lets a block be opened in a modal
pop-up via a button. Instead of a block's content always sitting in the page, you
place a button that, when clicked, opens the chosen block's content in a modal
dialog.

Use it for on-demand content that doesn't need to be visible all the time — help
text, a form, a promotion — where a button that pops the content open keeps the page
tidy until the visitor asks for it. It builds on Drupal core's Block module.

This is a content-display/UX feature. The block's content follows normal block
access rules, and the module plays no role in access control of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. You configure the modal button on the block
itself, on the block's configuration form under **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and edit (or place) the block whose content
   you want to open in a modal.
2. In the block's configuration, enable/configure the **modal button**.
3. Save the block.

Visitors now see the button; clicking it opens the block's content in a modal.
