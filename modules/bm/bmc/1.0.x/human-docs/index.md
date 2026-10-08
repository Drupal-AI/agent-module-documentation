# Buy Me a Coffee — manual setup guide

**Buy Me a Coffee** (`bmc`) adds a *Buy Me a Coffee* donation button to your site
as a placeable block. Buy Me a Coffee is a third‑party service that lets visitors
send you a small tip or support payment; this module embeds that service's widget
so the button appears on your Drupal pages and links supporters into BMC's
donation flow.

The block loads **Buy Me a Coffee's own JavaScript widget**, and the actual
donation and payment happen entirely on Buy Me a Coffee's side — Drupal just
displays the button. You identify your account with your public Buy Me a Coffee
username; there is no secret API key or token to store, because the username is a
public embed identifier, not a credential.

It depends on core's Block module and provides its own permission for controlling
who may administer the button. It targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Because the button is a block, you place and configure it from the Block Layout
page:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the button, and choose the
   **Buy Me a Coffee** block.
3. Enter your Buy Me a Coffee **username** (the same one that appears in your
   `buymeacoffee.com/<username>` link) and adjust any widget options offered.
4. Save the block and its placement.

The button then renders in that region and hands visitors off to Buy Me a Coffee
to complete a donation. Because the widget is third‑party JavaScript, you are
trusting Buy Me a Coffee with the on‑page donation experience.
