# Missing Translation Fallback Language — manual setup guide

**Missing Translation Fallback Language** (`missing_translation_fallback_language`)
lets you choose, per language, which *other* language's translation should be used
when a translation is missing — instead of always falling back to English or the
source string. The classic example is a site in Dutch and Flemish: a few strings
have specific Flemish translations, but for most, the Dutch translation will do, so
you set Dutch as the fallback for Flemish.

It's a small, focused multilingual helper. It depends only on core's **Language**
module and supports Drupal 8 through 11. There is no dedicated settings form of its
own — instead it adds a fallback-language option to each configured language on the
standard core **Languages** admin page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — you set the fallback on the core
Languages screen, as described below.

## Where it lives in the admin menu

The setting lives on the core **Configuration → Regional and language → Languages**
page (`/admin/config/regional/language`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **`/admin/config/regional/language`**.
3. Edit a language (or use its fallback option) and choose which other language
   should supply translations when this language is missing one. For example, set
   Dutch as the fallback for Flemish.
4. Save. Untranslated strings and content in that language now fall back to your
   chosen language rather than to English or the source.

> **Note:** This module is marked *not covered* by Drupal's security advisory
> policy, so weigh that as you would for any such contrib module before relying on
> it in production.
