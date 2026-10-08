# Dropdown Language Switcher — manual setup guide

**Dropdown Language Switcher** (`dropdown_language`) gives a multilingual site a
compact language switcher **block** that renders your languages as a single
dropdown (Drupal's themable "dropbutton") instead of the plain bulleted list of
links that core's own language switcher produces. The current language floats to
the top and the switcher fits neatly into a header, sidebar, or footer.

The module ships one block plugin that is derived per language‑negotiation type
(Interface text, Content, URL, and so on), so you can place a separate dropdown
for each type you use. The block only appears on genuinely multilingual sites
(two or more languages) and quietly hides itself on 403/404 pages. A single
global settings form controls how every dropdown labels its languages — full
Language Name, uppercase language code (EN, FR, DE), Native Name, or fully Custom
Labels — plus an optional "Switch Language" fieldset wrapper, an SEO option to
drop links to untranslated content, and an option to keep the block visible even
when only one language currently applies. When you choose Custom Labels, each
placed block instance gains per‑language text fields so you can word the labels
however you like.

The module works as soon as you enable it, place the block, and (optionally)
adjust the global label style. It requires only core's **Language** and **Block**
modules, with no external libraries, permissions, or Drush commands. Note that
this release targets **Drupal 11.3+** on **PHP 8.3–8.5**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global label settings form and
   how to place and tune the switcher block.

## Where it lives in the admin menu

The global settings live at **Configuration → Regional and language → Dropdown
Language Switcher** (`/admin/config/regional/dropdown-language-switcher`). You
place the block itself from **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

Enable the module, then place the **Dropdown Language** block in a region on the
Block layout page and — if you want something other than full language names —
adjust the label style on the settings form. See
[Configuration](configuration/index.md) for the field‑by‑field walkthrough.
