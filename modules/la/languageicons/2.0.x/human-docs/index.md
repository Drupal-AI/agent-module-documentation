# Language Icons — manual setup guide

**Language Icons** (`languageicons`) adds a small flag or icon next to each link in
Drupal's Language switcher, so visitors can recognize their language at a glance
rather than reading a list of language names. It is a long‑standing spin‑off from
the old Internationalization (i18n) package, and it ships with about 60 ready‑made
PNG flag icons.

The module works by quietly hooking into the language switch links that core (and
other modules) generate, and dropping a themed flag image into each one. You decide
whether the flag sits **before** the language name, **after** it, or **replaces**
the text entirely for a compact flag‑only switcher. A settings form lets you set the
icon size and, if you want, point the module at your own icon set instead of the
bundled flags.

Language Icons only shows icons where language links are actually rendered, so it
relies on the core **locale** module and a visible **Language switcher** block. Once
those are in place and you have at least two languages configured, the flags appear
automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (the core Locale module is the one dependency).
2. [Configuration](configuration/index.md) — the settings form (placement, size,
   icon path) and how to get the Language switcher block on the page.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Regional and language → Language icons**
(`/admin/config/regional/language/icons`). The Language switcher block itself is
placed from **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Make sure you have at least two languages set up and the core **Language
   switcher** block placed in a visible region.
2. Enable Language Icons — flags appear on the switcher immediately using the
   bundled flag set.
3. Optionally visit the settings form to change placement, size, or the icon path
   (see [Configuration](configuration/index.md)).
