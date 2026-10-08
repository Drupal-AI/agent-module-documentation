# Language Switcher Dropdown — manual setup guide

**Language Switcher Dropdown** (`lang_dropdown`) replaces core's plain list of language
links with a compact **dropdown `<select>`** that visitors use to switch the site language.
It is a drop‑in alternative to Drupal's built‑in *Language switcher* block: instead of a
column of links in your sidebar or header, you get one tidy selector that takes far less
space — handy on mobile and in cramped theme regions.

The module provides a single block, **Language dropdown switcher**, which you place and
configure through Drupal's normal **Block layout** UI. Everything about how it looks and
behaves lives in that block's settings: the **output style** (a plain accessible HTML
select, or a fancier widget powered by the Chosen, msDropdown, or ddSlick JavaScript
libraries), the **label format** for each language (translated name, native name, or ISO
code), a fixed width, and behavior toggles such as hiding the block when only one language
exists or redirecting to the front page after a switch. If you also install the **Language
Icons** module it can show a flag beside each language.

It depends only on core's **Language** module. The plain HTML‑select style needs no extra
libraries and works out of the box; the Chosen, msDropdown, and ddSlick styles only render
their fancy look if you have added those JavaScript libraries. The block also hides itself
automatically on single‑language sites, so it never clutters a site that isn't multilingual.

This guide is written for a **human** placing and tuning the block in the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — place the block and walk through every setting
   in its block form (output style, label format, width, and the behavior toggles).

## Where it lives in the admin menu

There is **no dedicated settings page**. You work entirely through **Structure → Block
layout** (`/admin/structure/block`) — the module's `configure` link points there. Place the
**Language dropdown switcher** block into a region and its settings form is where you choose
the style and options. Language *detection* (what actually changes when a visitor picks a
language) is core's job, configured at **Configuration → Regional and language → Languages →
Detection and selection**.
