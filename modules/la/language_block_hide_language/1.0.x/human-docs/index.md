# Language Block Hide Language — manual setup guide

**Language Block Hide Language** (`language_block_hide_language`) lets you hide
specific languages from Drupal's core **language‑switcher block**. Sometimes a
language exists on your site — it's enabled, and content is being translated — but
you're not ready to offer it to visitors yet because the translation is still in
progress. This module lets you leave that language enabled while keeping it out of
the switcher, so visitors don't stumble onto half‑translated pages through the
language menu.

It depends only on core's **Language** module and lives in the Multilingual
package.

One important thing to understand: this is **presentation, not access control**.
Hiding a language from the switcher block only removes it from that UI — it does
**not** restrict access to that language's content. The language is still reachable
directly by URL (for example via its path prefix). Use this to tidy the switcher,
not to secure or gate content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings page**. You choose which languages to hide from the
configuration of the language‑switcher block itself — see "How to use it" below.

## How to use it

1. Make sure you have the core **language‑switcher block** placed in a region
   (**Structure → Block layout**, place the "Language switcher" block if it isn't
   already there).
2. Edit that block's configuration. With this module enabled, the block settings
   now include the option to **hide one or more languages** from the switcher.
3. Tick the language(s) you want to omit — for instance an in‑progress translation —
   and save the block.
4. The hidden languages disappear from the switcher, while remaining enabled and
   still reachable by URL for anyone (or any process) that needs them.
