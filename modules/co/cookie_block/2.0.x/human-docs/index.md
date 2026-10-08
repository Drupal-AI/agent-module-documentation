# Cookie Block — manual setup guide

**Cookie Block** (`cookie_block`) adds a **block‑visibility condition based on a
cookie**. Once enabled, every block's configuration form gains a condition where
you name a cookie (and optionally a value), and the block is then shown or hidden
depending on whether the visitor is carrying that cookie. It is a small
site‑building helper — a plugin‑based condition, nothing more — and works across
Drupal 8, 9, 10, and 11 with no dependencies.

Typical uses are presentational: show a block only to returning visitors, reveal
something to people who accepted a banner, or align a block with a consent cookie.
The module works the moment you enable it; there is no settings page — you
configure the condition per block.

**Important:** cookies are **client‑controlled** — a visitor can set or clear a
cookie in one line of browser console — so this is a **visibility/UX** condition,
**not** a security gate. Never use it as the only control protecting sensitive
content; gate anything that must not leak on a permission or entity access check
and use the cookie only for presentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form. You set the
cookie condition on each block, described under "How to use it" below.

## Where it lives in the admin menu

Cookie Block adds no admin page of its own. You use it from **Structure → Block
layout** when you place or configure a block.

## How to use it

1. Go to **Structure → Block layout** and place or edit a block.
2. In the block's configuration, open the visibility settings and find the
   **Cookie** condition added by this module.
3. Enter the **cookie name** to match, and optionally the **value** to compare
   against.
4. Save the block. It will now appear only when the visitor carries the matching
   cookie (or, if you invert the condition, only when they do not).

Remember: this decides *what is displayed*, never *what is permitted*.
