# Discord Widget — manual setup guide

**Discord Widget** (`discord_widget`) embeds Discord's own **server widget** — the
little panel showing who is online in your Discord server, with a "Join" button —
into a Drupal page. It does this by rendering Discord's widget as an `<iframe>`,
which means the live member list and join flow come straight from Discord; your
site just hosts the frame.

The problem it solves is community discovery: if you run a public Discord for a
project, game, or organisation, a widget on your homepage or sidebar lets visitors
see the community is active and jump straight in, without leaving your site.

The module provides a **block** (and a render template for developers), so setup is
purely site‑building — no admin settings page, no permissions of its own, no
server‑side requests. You place the "Discord Widget" block in a region and fill in
your Discord **Server ID** plus a few display options; the visitor's browser then
loads the iframe directly from Discord. It has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the widget in Discord, place
   the block, and set the Server ID, size, and theme.

## Where it lives in the admin menu

There is no dedicated settings page. You use the module entirely through **Block
layout** — go to **Structure → Block layout** (`/admin/structure/block`), place the
**Discord Widget** block in a region, and configure it there. See
[Configuration](configuration/index.md) for the fields.
