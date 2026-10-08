# Google Translator — manual setup guide

**Google Translator** (`google_translator`) adds a placeable block that embeds
Google Translate's client-side "Website Translator" widget. Visitors pick a
language and the current page is machine-translated in their browser — no server
work, no API key, and nothing stored on your site. It is a quick way to offer
"read this page in your language" on an otherwise single-language site.

Setup has two parts: choose which languages the selector offers (and how it
looks) on the settings form, then place the **Google Translator** block in a
region such as a header, sidebar, or footer. Because translation happens entirely
in the visitor's browser through Google's script, you do not manage any
credentials and no translated content is saved.

You can optionally show a legal disclaimer — a small modal that pops up the first
time a visitor uses the selector, warning that translations come from a
third-party service. If you fill in disclaimer text, visitors must accept it
before the page is translated; leave it blank to skip the modal entirely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick the languages and display
   mode, write the optional disclaimer, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Google
Translator** (`/admin/config/regional/google-translator`), gated by the
**Administer google_translator settings** permission (core *Administer site
configuration* also grants access). The block itself is placed from **Structure →
Block layout** (`/admin/structure/block`) — look for **Google Translator** under
the *Google Translator* category.
