# Background Block — manual setup guide

**Background Block** (`background_block`) lets you give any block a **background
colour** without writing custom CSS. It adds a per‑block colour option so you can pick
out or visually group blocks straight from the block's own configuration.

It depends on core's **Block** module and defines its own permission. It's a
presentation‑only feature — it changes how a block looks, not what it contains or who
can see it — so there's no site‑wide settings page. It runs on Drupal 8.9 through 11.

Because the colour is set right on each block, there's nothing to configure centrally;
the how‑to is covered here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There is no central settings form — you set the colour on each block in **Structure →
Block layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and edit the block you want to colour (or place a
   new one).
2. On the block's configuration form, set its **background colour** using the option the
   module adds.
3. Save. The block renders with that background colour on the front end.

Repeat per block for as many as you want to style. Managing this is governed by the
module's own permission, so grant it to the roles that configure blocks.
