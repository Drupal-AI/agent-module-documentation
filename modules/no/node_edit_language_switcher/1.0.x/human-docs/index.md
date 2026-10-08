# Node Edit Language Switcher — manual setup guide

**Node Edit Language Switcher** (`node_edit_language_switcher`) adds a **language
switcher to the node edit form**, so editors can move between a node's translations —
or start a new one — without leaving the edit screen. On a multilingual site,
switching languages normally means going back out to the content list or the
translations tab; this keeps that motion inside the form and speeds up working across
every language a node has.

It's purely an **editorial convenience**. It adds no content model of its own and
carries no access role — translation access still follows Drupal core's normal rules,
so the switcher only offers languages the editor is actually permitted to work with.
It works across Drupal 8 through 11 and requires no configuration; the switcher
appears on the node edit form once the module is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — see "How to use it" below.

## Where it lives

The module adds no admin settings page. The language switcher appears directly on the
**node edit form** for translatable content.

## How to use it

1. Make sure your site has more than one language configured and the content type is
   set up for translation (core **Language** and **Content Translation**).
2. Edit a translatable node. Use the language switcher on the form to jump to another
   translation, or to begin adding content in a language that doesn't have a
   translation yet — all without leaving the edit screen.
