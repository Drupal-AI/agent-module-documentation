# GTranslate — manual setup guide

**GTranslate** (`g_translate`) places a **Google Translate widget** on your site.
A visitor picks a language and Google machine‑translates the page in their
browser — a hundred languages from one block, with no translation workflow, no
cost, and no changes to your content model. It is a maintained fork of the older
`gtranslate` module, updated for modern Drupal, and it depends only on core's
Block module.

The appeal is obvious, but it is important to be clear about what this is and is
**not**, because it is frequently proposed as an alternative to Drupal's own
translation system and it is not one:

- **The translation is not yours.** Nothing is stored, reviewed, or correctable.
  A mistranslated legal statement, medical instruction, price, or safety notice is
  published in your name and can only be fixed by rewording the source.
- **It is not indexed.** Search engines index the original page, so machine
  translations bring no multilingual search visibility — usually the main reason
  people want other languages in the first place.
- **It is a third‑party script** that sees every page a visitor reads, which is a
  consent and data‑protection question you should account for.
- **It misses what matters most**: text inside images and PDFs, form validation
  messages, and anything rendered after the page loads.

Where it is genuinely the right answer: a small organisation with the occasional
non‑native visitor, an internal tool, or a site where the realistic alternative is
no translation at all. Use it as a convenience layer on a monolingual site, and
use core's translation system for the languages your organisation actually commits
to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and where to place
   the translation block.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → GTranslate**
(`/admin/config/regional/g-translate`). The translation widget itself is a block,
placed at **Structure → Block layout** (`/admin/structure/block`).
