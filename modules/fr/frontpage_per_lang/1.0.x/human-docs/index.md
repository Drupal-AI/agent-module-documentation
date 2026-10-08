# Frontpage Per Language — manual setup guide

**Frontpage Per Language** (`frontpage_per_lang`) lets a multilingual site serve a
different front page for each language. Out of the box, Drupal has one site-wide
front page; this module lets you point `/` at a language-appropriate landing page
so a visitor browsing in German lands on your German home page and a visitor
browsing in Brazilian Portuguese lands on the Portuguese one.

It works by adding, when your site has more than one language, a **Default front
page** textfield for each non-default language directly on Drupal's own *Basic site
settings* form. You enter a path per language, and at request time the module
transparently rewrites an inbound `/` to that language's front page based on the
current content language. There is no separate admin screen to learn — the settings
live where you already manage your front page.

Under the hood it keeps everything consistent: front-page-only blocks still show on
each language's landing page, front-page caching stays correct, and the module emits
`hreflang` alternate links on the front page for search engines. The default
language's front page continues to come from core, unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it needs core's Language module).
2. [Configuration](configuration/index.md) — set a front page path per language on
   the Basic site settings form.

## Where it lives in the admin menu

Frontpage Per Language adds no admin page of its own. You configure it on Drupal's
**Configuration → System → Basic site settings**
(`/admin/config/system/site-information`), where it adds one front-page field per
non-default language.
