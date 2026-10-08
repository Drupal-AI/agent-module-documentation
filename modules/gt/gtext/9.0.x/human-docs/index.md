# gText — manual setup guide

**gText** (`gtext`) is a string-translation utility for multilingual sites. Built on
core's **Locale** module, it gives site builders a dedicated page for browsing and
translating the site's interface strings, a Twig helper for emitting translatable
text from templates, and optional **Google Translate** machine translation to speed
up filling in the translations. Despite the name, this module is about **text and
string translation, not fonts or typography** — "Google" here means Google
*Translate*.

At its core is a "Translating texts" admin area at `/admin/config/texts` where you
can list translatable source strings (grouped by their locale context) and edit each
one's translation per language. It adds a `gtext()` Twig helper (and a `gtext`
service for code) so themes can output context-aware translatable strings. To make
manual translation faster, it can pre-fill suggestions from Google Translate: if you
configure a **Google Cloud Translate API key** it uses the official Google client;
if you leave the key empty it falls back to a free, unofficial translate.google.com
endpoint capped at 1000 characters per request. It also adds inline "translate"
buttons to core's config-translation and entity-translation forms for users who are
allowed to see them.

Two permissions gate the module: *Access gtext translate strings* (the
string-translation UI, marked as a restricted permission) and *Access gtext
translate* (the inline translate buttons). gText depends on core **Locale** and pulls
in the `google/cloud-translate` PHP library via Composer. It defines its own config
and permissions but provides no Drush commands, and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Google API key, the permissions,
   and the translation UI.

## Where it lives in the admin menu

- **Configuration → Regional and language → Translating texts** area at
  **`/admin/config/texts`** — the string-translation UI (gated by *Access gtext
  translate strings*).
- The Google API key settings form is at **`/admin/config/gtext/settings`** (gated by
  *Administer site configuration*).

## How to use it

Enable the module, decide whether you want machine-translation help (if so, add a
Google Cloud Translate API key — see [Configuration](configuration/index.md)), grant
the two permissions to your translators, then use the **Translating texts** page to
translate strings, or add the `gtext()` helper to your Twig templates for
context-aware translatable text.
