# AI Content Translator — manual setup guide

**AI Content Translator** (`ai_content_translator`) uses AI to translate three
kinds of text on your site: **content entities** (like nodes), **taxonomy terms**,
and **interface strings** (the UI text managed by Locale). It integrates with
Drupal's core content-translation and locale systems, so a site's content *and* its
interface can be machine-translated through the AI module, with an editor reviewing
the result.

Covering interface strings as well as content is what sets it apart from a
content-only translator: you can machine-translate the words in menus, buttons, and
messages alongside your articles. As always, the AI produces **draft**
translations that a human reviews before they are trusted.

Translation sends the text to the configured AI provider, so content leaves your
site to a third-party API and each request costs money. Two permissions control
it: `administer ai content translator` for configuration and
`translate content with ai` for running translations. It depends on core's
Language, Content Translation, and Locale modules and requires Drupal 11.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm your languages and AI provider are set up.

## How to use it

Grant **`translate content with ai`** to the editors who should run translations
and keep **`administer ai content translator`** with administrators. With your
languages configured and an AI provider in place, the module lets those editors
machine-translate content entities, taxonomy terms, and interface strings into
your enabled languages — always as a draft to review before publishing. Keep in
mind that every translation sends the text to the external AI provider and is a
billed call.
