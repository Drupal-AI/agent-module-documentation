# Notifybar — manual setup guide

**Notifybar** (`notifybar`) shows a **site‑wide notification bar** — a fully
theme‑able coloured horizontal strip at the top (or bottom) of the page carrying
an announcement. It is the module you reach for when you need a site‑wide notice:
scheduled maintenance, a promotion, or an alert that everyone should see.

It works through a **block**. Once enabled, a block named **Notifybar** becomes
available, and you configure the message, an optional button, and the colours
right in the block's settings. You can place it in a specific region, or use its
"Show notifybar" option to pin it to the top of the page (or hide it). It depends
only on core **Block**.

There is no separate settings page (`configure` is null) — all configuration
lives in the block. As with any announcement banner, remember to **clear Drupal's
caches** after changing the message so visitors see the update.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the Notifybar block's fields:
   message, button, colours, and placement.

## Where it lives in the admin menu

Everything happens under **Structure → Block layout**
(`/admin/structure/block`), where you add and configure the **Notifybar** block.
There is no dedicated configuration screen elsewhere in the admin menu.
