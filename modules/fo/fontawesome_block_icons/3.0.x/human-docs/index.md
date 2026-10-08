# Font Awesome Block Icons — manual setup guide

**Font Awesome Block Icons** (`fontawesome_block_icons`) lets you add a **Font
Awesome icon to a block's title**, straight from the block's configuration — no
custom CSS or template overrides required. It extends Drupal's individual blocks so
each one can show an icon next to its heading, with control over the icon's size
and an optional custom CSS class for further styling.

The idea is to save you the headache of writing CSS just to put an icon on a block
title. You configure everything on the block itself: pick the Font Awesome icon,
set its size, and (optionally) add a custom CSS class to fine-tune its look. It is
purely a display/theming feature — it affects how block titles render and has no
content or access role.

> **You need Font Awesome available on your site** for the icons to actually
> render — for example through your theme or the Font Awesome module. This module
> adds the per-block icon settings; it relies on the Font Awesome icon library
> being loaded on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per-block icon options, field by
   field.

## Where it lives in the admin menu

There is no central settings page. The module adds a **Fontawesome Block Icon**
section to each block's configuration form, reached from **Structure → Block
layout** (`/admin/structure/block`) by configuring an individual block.

## How to use it

1. Go to **Structure → Block layout** and click **Configure** on the block you
   want to give an icon.
2. In the block's configuration, find the **Fontawesome Block Icon** options.
3. Choose the icon, set its size, and optionally add a custom CSS class.
4. Save the block. The icon now appears with the block's title.
