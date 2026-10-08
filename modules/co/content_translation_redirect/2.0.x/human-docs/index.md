# Content Translation Redirect — manual setup guide

**Content Translation Redirect** (`content_translation_redirect`) handles a common
multilingual problem gracefully: what to show when a visitor asks for a piece of
content in a language it hasn't been translated into. Instead of rendering a
half-translated or fallback-language page, the module redirects the visitor — to the
original content, or to a path you choose — using an HTTP status code you configure.

You set this up with **redirect rules**, managed on one admin screen. Each rule can
apply to every entity type at once (the locked **Default** rule), to a whole entity
type (for example all nodes, or all taxonomy terms), or to a single bundle (for
example only Articles). A rule carries three things: a **status code** (301, 302,
etc., or "disabled"), an optional **redirect path** (leave it blank to send visitors
to the same content in its original language), and a **translation mode** that decides
whether the rule acts on translatable content, untranslatable content, or all of it.

At request time the module picks the most specific matching rule — bundle first, then
entity type, then the Default — and issues the redirect. It only fires on multilingual
sites, and only for content entity types that are translatable and have a canonical
page. This is good for SEO (proper canonical redirects instead of duplicate or
untranslated pages) and for keeping a coherent language experience while a translation
effort is still in progress.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and tune redirect rules, and
   understand how they're matched.

## Where it lives in the admin menu

The redirect rules are managed at **Configuration → Regional and language → Content
Translation Redirect** (`/admin/config/regional/content-translation-redirect`),
governed by the **Administer content translation redirects** permission.
