# Menu Block Current Language — manual setup guide

**Menu Block Current Language** (`menu_block_current_language`) is a drop-in
replacement for core's menu block that **hides any menu link with no translation
for the current language**. On a multilingual site, this means each language's
menu only lists the items that actually exist in that language — no dead links to
untranslated content, no duplicate default-language entries showing through.

You use it by placing *its* block instead of the core System menu block for a
given menu. Everything else about the menu block behaves as normal — start level,
depth, expand-all — but before the tree renders, the module removes links that
lack a translation in the current interface/content language.

It's smart about *how* it detects a translation, checking each link by its type:
custom menu links (`menu_link_content` entities) are checked for a translation,
Views-provided menu links are checked against the view's language configuration,
and string-translated default links can be checked via the locale system. Which of
these providers are filtered is a per-block setting. Developers can override any
single decision through an event.

The module has **no global settings page and no permissions of its own** — you
configure it per block at **Block layout**. It depends on core's **Block** and
**Locale** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block in place of the core
   menu block, and choose which link types get language-filtered.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the block at
**Structure → Block layout** (`/admin/structure/block`); its blocks appear under
the admin category **"Menu block current language"**.

## How to use it

Enable the module, then at **Block layout** place the **Menu block current
language** block for the menu you want (for example your Main navigation), in the
same region where the core menu block would go — and remove the core block for
that menu so you don't have both. Optionally adjust which link types are filtered.
See [Configuration](configuration/index.md) for the details.
